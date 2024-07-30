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

resource "azurerm_subnet" "subnet-tc" {
  for_each             = var.subnet_map
  name                 = "Wolff-Subnet_${each.key}-${var.prefix}"
  resource_group_name  = azurerm_resource_group.resource_group_tc.name
  virtual_network_name = azurerm_virtual_network.virtual_network_tc.name
  address_prefixes     = each.value
}
