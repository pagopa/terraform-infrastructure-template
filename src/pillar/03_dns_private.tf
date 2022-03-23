#
# internal.devopslab...
#
resource "azurerm_private_dns_zone" "internal_devopslab" {
  count               = (var.prod_dns_zone_prefix == null || var.external_domain == null) ? 0 : 1
  name                = local.dns_zone_private_name
  resource_group_name = azurerm_resource_group.rg_vnet.name

  tags = var.tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "internal_devopslab_vnet" {
  name                  = local.vnet_resource_group_name
  resource_group_name   = azurerm_resource_group.rg_vnet.name
  private_dns_zone_name = azurerm_private_dns_zone.internal_devopslab[0].name
  virtual_network_id    = module.vnet.id

  tags = var.tags
}

#
# internal.lab.devopslab...
#
resource "azurerm_private_dns_zone" "internal_lab_devopslab" {
  count               = (var.lab_dns_zone_prefix == null || var.external_domain == null) ? 0 : 1
  name                = local.dns_zone_lab_private_name
  resource_group_name = azurerm_resource_group.rg_vnet.name

  tags = var.tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "internal_lab_devopslab_vnet" {
  name                  = local.vnet_resource_group_name
  resource_group_name   = azurerm_resource_group.rg_vnet.name
  private_dns_zone_name = azurerm_private_dns_zone.internal_lab_devopslab[0].name
  virtual_network_id    = module.vnet.id

  tags = var.tags
}
