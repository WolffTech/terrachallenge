module "resource_group" {
  source    = "./modules/ResourceGroup"
  base_name = var.prefix
  location  = var.location
  tags      = var.tags
}
