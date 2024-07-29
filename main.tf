module "resource_group" {
  source    = "./modules/ResourceGroup"
  base_name = var.prefix
  location  = var.location
  tags      = var.tags
}

module "network" {
  source              = "./modules/Network/"
  base_name           = var.prefix
  location            = module.resource_group.rg_location_out
  resource_group_name = module.resource_group.rg_name_out
  subnet_cidrs        = var.cidrs
  address_space       = var.address_space
  nsg_rules           = var.nsg_rules
  tags                = var.tags
}
