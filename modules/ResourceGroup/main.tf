resource "azurerm_resource_group" "this" {
  name = "${var.base_name}-RG"
  location = var.location
  tags = var.tags
}
