data "azurerm_container_registry" "acr" {
  name                = local.docker_registry_name
  resource_group_name = local.docker_rg_name
}
