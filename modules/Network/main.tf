resource "azurerm_virtual_network" "this" {
  name                = "${var.base_name}-vnet"
  address_space       = var.address_space
  resource_group_name = var.resource_group_name
  location            = var.location
  tags                = var.tags
}

resource "azurerm_network_security_group" "this" {
  name                = "${var.base_name}-SecurityGroup"
  location            = var.location
  resource_group_name = var.resource_group_name

  dynamic "security_rule" {
    for_each = var.nsg_rules
    content {
      name                       = security_rule.value.name
      priority                   = security_rule.value.priority
      direction                  = security_rule.value.direction
      access                     = security_rule.value.access
      protocol                   = security_rule.value.protocol
      source_port_range          = security_rule.value.source_port_range
      destination_port_range     = security_rule.value.destination_port_range
      source_address_prefix      = security_rule.value.source_address_prefix
      destination_address_prefix = security_rule.value.destination_address_prefix
    }
  }

  tags = var.tags
}

resource "azurerm_subnet" "this" {
  for_each = var.subnet_cidrs

  name                 = each.key
  virtual_network_name = azurerm_virtual_network.this.name
  resource_group_name  = azurerm_virtual_network.this.resource_group_name
  address_prefixes     = [each.value]
}

resource "azurerm_subnet_network_security_group_association" "this" {
  count = contains(keys(var.subnet_cidrs), "Web") ? 1 : 0

  subnet_id = azurerm_subnet.this["Web"].id
  network_security_group_id = azurerm_network_security_group.this.id

  depends_on = [azurerm_subnet.this]
}
