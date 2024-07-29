variable "prefix" {
  description = "Prefix for all resources"
  type        = string
  default     = "terrachallenge"
}

variable "location" {
  description = "Default location for resources"
  type        = string
  default     = "eastus"
}

variable "tags" {
  description = "Tags used on most resources that require them"
  type        = map(string)
}

variable "cidrs" {
  description = "Name and CIDRs for subnets"
  type        = map(string)
}

variable "address_space" {
  description = "Address space for the Virtual Network"
  type        = list(string)
}

variable "nsg_rules" {
  description = "List of NSG rules"
  type = list(object({
    name                       = string
    priority                   = number
    direction                  = string
    access                     = string
    protocol                   = string
    source_port_range          = string
    destination_port_range     = string
    source_address_prefix      = string
    destination_address_prefix = string
  }))
}
