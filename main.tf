resource "azurerm_resource_group" "this" {
  name     = "Wolff-RG-${var.prefix}"
  location = var.location
  tags     = var.tags
}

resource "azurerm_virtual_network" "this" {
  name                = "Wolff-VN-${var.prefix}"
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location
  address_space       = var.address_space
  tags                = var.tags
}

resource "azurerm_subnet" "this" {
  for_each             = var.subnet_map
  name                 = "Wolff-Subnet_${each.key}-${var.prefix}"
  resource_group_name  = azurerm_resource_group.this.name
  virtual_network_name = azurerm_virtual_network.this.name
  address_prefixes     = each.value
}

resource "azurerm_network_security_group" "this" {
  name                = "Wolff-NSG-${var.prefix}"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
}

resource "azurerm_subnet_network_security_group_association" "this" {
  subnet_id                 = azurerm_subnet.this["Web"].id
  network_security_group_id = azurerm_network_security_group.this.id
}
