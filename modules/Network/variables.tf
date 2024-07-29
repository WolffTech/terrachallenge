variable "base_name" {
  description = "Default name for Networks."
  type        = string
}

variable "address_space" {
  description = "Address space for the Virtual Network"
  type        = list(string)
}

variable "resource_group_name" {
  description = "Name of the resource group that will contain the network"
  type        = string
}

variable "location" {
  description = "Location of the Network"
  type        = string
}

variable "tags" {
  description = "Tags to put on the resource group"
  type        = map(string)
  default     = {}
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

variable "subnet_cidrs" {
  description = "Map of the subnet names to CIDRs"
  type        = map(string)
}

