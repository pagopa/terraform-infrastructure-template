resource "azurerm_resource_group" "rg_docker" {
  name     = local.docker_rg_name
  location = var.location
  tags     = var.tags
}

#
# 📦 ACR
#
module "acr" {
  source              = "git::https://github.com/pagopa/azurerm.git//container_registry?ref=v2.0.2"
  name                = local.docker_registry_name
  resource_group_name = azurerm_resource_group.rg_docker.name
  location            = azurerm_resource_group.rg_docker.location

  #https://docs.microsoft.com/en-us/azure/app-service/faq-app-service-linux#multi-container-with-docker-compose
  admin_enabled = true

  tags = var.tags
}
