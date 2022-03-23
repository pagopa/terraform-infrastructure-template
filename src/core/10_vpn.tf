# ## VPN subnet
# module "vpn_snet" {
#   source                                         = "git::https://github.com/pagopa/azurerm.git//subnet?ref=v1.0.58"
#   name                                           = "GatewaySubnet"
#   address_prefixes                               = var.cidr_subnet_vpn
#   resource_group_name                            = azurerm_resource_group.rg_vnet.name
#   virtual_network_name                           = module.vnet.name
#   service_endpoints                              = []
#   enforce_private_link_endpoint_network_policies = true
# }

# data "azuread_application" "vpn_app" {
#   display_name = format("%s-app-vpn", local.project)
# }

# module "vpn" {
#   source = "git::https://github.com/pagopa/azurerm.git//vpn_gateway?ref=v1.0.36"

#   depends_on = [
#     azurerm_log_analytics_workspace.log_analytics_workspace
#   ]

#   name                = format("%s-vpn", local.project)
#   location            = var.location
#   resource_group_name = azurerm_resource_group.rg_vnet.name
#   sku                 = var.vpn_sku
#   pip_sku             = var.vpn_pip_sku
#   subnet_id           = module.vpn_snet.id

#   # TODO uncomment when security team will allow this project
#   #log_analytics_workspace_id = var.env_short == "p" ? data.azurerm_key_vault_secret.sec_workspace_id[0].value : null
#   #log_storage_account_id     = var.env_short == "p" ? data.azurerm_key_vault_secret.sec_storage_id[0].value : null

#   vpn_client_configuration = [
#     {
#       address_space         = ["172.16.1.0/24"],
#       vpn_client_protocols  = ["OpenVPN"],
#       aad_audience          = data.azuread_application.vpn_app.application_id
#       aad_issuer            = format("https://sts.windows.net/%s/", data.azurerm_subscription.current.tenant_id)
#       aad_tenant            = format("https://login.microsoftonline.com/%s", data.azurerm_subscription.current.tenant_id)
#       radius_server_address = null
#       radius_server_secret  = null
#       revoked_certificate   = []
#       root_certificate      = []
#     }
#   ]

#   tags = var.tags
# }
