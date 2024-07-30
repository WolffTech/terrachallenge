resource "azurerm_resource_group" "resource_group_tc" {
  name     = "Wolff-RG-${var.prefix}"
  location = var.location
  tags     = var.tags
}
