# 🔐 KV
data "azurerm_key_vault_secret" "apim_publisher_email" {
  name         = "apim-publisher-email"
  key_vault_id = data.azurerm_key_vault.kv.id
}

## 🎫  Certificates

data "azurerm_key_vault_certificate" "apim_internal_certificate" {
  name         = var.apim_api_internal_certificate_name
  key_vault_id = data.azurerm_key_vault.kv.id
}

# 🧵 DNS ZONE
data "azurerm_private_dns_zone" "internal" {
  name                = "internal.${var.prod_dns_zone_prefix}.${var.external_domain}"
  resource_group_name = data.azurerm_resource_group.rg_vnet.name
}

#--------------------------------------------------------------------------------------------------

resource "azurerm_resource_group" "rg_api" {
  name     = "${local.project}-api-rg"
  location = var.location

  tags = var.tags
}

# APIM subnet
module "apim_snet" {
  source               = "git::https://github.com/pagopa/azurerm.git//subnet?ref=v2.1.21"
  name                 = "${local.project}-apim-snet"
  resource_group_name  = data.azurerm_resource_group.rg_vnet.name
  virtual_network_name = data.azurerm_virtual_network.vnet.name
  address_prefixes     = var.cidr_subnet_apim

  enforce_private_link_endpoint_network_policies = true
  service_endpoints                              = ["Microsoft.Web"]
}

###########################
## Api Management (apim) ##
###########################

module "apim" {
  source = "git::https://github.com/pagopa/azurerm.git//api_management?ref=v2.1.21"

  name = "${local.project}-apim"

  subnet_id           = module.apim_snet.id
  location            = azurerm_resource_group.rg_api.location
  resource_group_name = azurerm_resource_group.rg_api.name

  publisher_name       = var.apim_publisher_name
  publisher_email      = data.azurerm_key_vault_secret.apim_publisher_email.value
  sku_name             = var.apim_sku
  virtual_network_type = "Internal"

  redis_connection_string = null
  redis_cache_id          = null

  # This enables the Username and Password Identity Provider
  sign_up_enabled = false

  lock_enable                              = var.lock_enable
  application_insights_instrumentation_key = data.azurerm_application_insights.application_insights.instrumentation_key

  tags = var.tags
}

#
# 🔐 Key Vault Access Policies
#

## api management policy ##
resource "azurerm_key_vault_access_policy" "api_management_policy" {
  key_vault_id = data.azurerm_key_vault.kv.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = module.apim.principal_id

  key_permissions         = []
  secret_permissions      = ["Get", "List"]
  certificate_permissions = ["Get", "List"]
  storage_permissions     = []
}

#
# 🏷 custom domain
#
resource "azurerm_api_management_custom_domain" "api_custom_domain" {
  api_management_id = module.apim.id

  proxy {
    host_name = local.api_internal_domain
    key_vault_id = replace(
      data.azurerm_key_vault_certificate.apim_internal_certificate.secret_id,
      "/${data.azurerm_key_vault_certificate.apim_internal_certificate.version}",
      ""
    )
  }
}

# api.internal.*.userregistry.pagopa.it
resource "azurerm_private_dns_a_record" "api_internal" {

  name    = "api"
  records = module.apim.*.private_ip_addresses[0]
  ttl     = var.dns_default_ttl_sec

  zone_name           = data.azurerm_private_dns_zone.internal.name
  resource_group_name = data.azurerm_resource_group.rg_vnet.name

  tags = var.tags
}
