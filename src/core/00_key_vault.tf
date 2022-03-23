data "azurerm_resource_group" "kv_rg" {
  name = var.key_vault_rg_name
}

#
# 🔐 KV
#
data "azurerm_key_vault" "kv" {
  name                = var.key_vault_name
  resource_group_name = var.key_vault_rg_name
}

# data "azurerm_key_vault_secret" "sec_workspace_id" {
#   count        = var.env_short == "p" ? 1 : 0
#   name         = "sec-workspace-id"
#   key_vault_id = data.azurerm_key_vault.kv.id
# }

# data "azurerm_key_vault_secret" "sec_storage_id" {
#   count        = var.env_short == "p" ? 1 : 0
#   name         = "sec-storage-id"
#   key_vault_id = data.azurerm_key_vault.kv.id
# }

## 🎫  Certificates

data "azurerm_key_vault_certificate" "app_gw_platform" {
  name         = var.app_gateway_api_certificate_name
  key_vault_id = data.azurerm_key_vault.kv.id
}

data "azurerm_key_vault_certificate" "apim_internal" {
  name         = var.apim_api_internal_certificate_name
  key_vault_id = data.azurerm_key_vault.kv.id
}
