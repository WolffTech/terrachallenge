resource "azurerm_resource_group" "resource_group_tc" {
  name     = "Wolff-RG-${var.prefix}"
  location = var.location
  tags     = var.tags
}

resource "azurerm_virtual_network" "virtual_network_tc" {
  name                = "Wolff-VN-${var.prefix}"
  resource_group_name = azurerm_resource_group.resource_group_tc.name
  location            = azurerm_resource_group.resource_group_tc.location
  address_space       = var.address_space
  tags                = var.tags
}
