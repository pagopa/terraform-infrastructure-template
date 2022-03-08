data "azurerm_public_ip" "aks_pip" {
  name                = local.aks_public_ip_index_name
  resource_group_name = local.vnet_resource_group_name
}
