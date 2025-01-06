locals {
  default_tags = {}
  all_tags     = merge(local.default_tags, var.tags)
}

resource "azurerm_resource_group" "this" {
  name     = var.name
  location = var.location

  tags = local.all_tags
}
