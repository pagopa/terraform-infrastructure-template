resource "azurerm_resource_group" "rg_vnet" {
  name     = local.vnet_resource_group_name
  location = var.location

  tags = var.tags
}

# vnet
module "vnet" {
  source              = "git::https://github.com/pagopa/azurerm.git//virtual_network?ref=v2.0.2"
  name                = local.vnet_name
  location            = azurerm_resource_group.rg_vnet.location
  resource_group_name = azurerm_resource_group.rg_vnet.name
  address_space       = var.cidr_vnet

  tags = var.tags
}

## Application gateway public ip ##
resource "azurerm_public_ip" "appgateway_public_ip" {
  name                = local.appgateway_public_ip_name
  resource_group_name = azurerm_resource_group.rg_vnet.name
  location            = azurerm_resource_group.rg_vnet.location
  sku                 = "Standard"
  allocation_method   = "Static"

  tags = var.tags
}

#
# ⛴ AKS public IP
#
resource "azurerm_public_ip" "aks_outbound" {
  count = var.aks_num_outbound_ips

  name                = "${local.aks_public_ip_name}-${count.index + 1}"
  location            = azurerm_resource_group.rg_vnet.location
  resource_group_name = azurerm_resource_group.rg_vnet.name
  sku                 = "Standard"
  allocation_method   = "Static"

  tags = var.tags
}

#
# Bastion public IP
#
resource "azurerm_public_ip" "bastion_pip" {
  count = var.aks_num_outbound_ips

  name                = local.bastion_public_ip_name
  location            = azurerm_resource_group.rg_vnet.location
  resource_group_name = azurerm_resource_group.rg_vnet.name
  sku                 = "Standard"
  allocation_method   = "Static"

  tags = var.tags
}
