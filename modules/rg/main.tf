locals {
  default_tags = {}
  all_tags     = merge(local.default_tags, var.az_tags)
}

resource "azurerm_resource_group" "this" {
  name     = var.az_rg_name
  location = var.az_rg_location

  tags = local.all_tags
}
