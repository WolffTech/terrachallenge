variable "prefix" {
  description = "Default name used for most resources"
  type        = string
}

variable "location" {
  description = "The default location for resources"
  type        = string
  default     = "eastus"
}

variable "tags" {
  description = "List of tags to use on all resources"
  type        = map(string)
}

variable "address_space" {
  description = "Address space to use for virtaul network"
  type        = list(string)
}

variable "subnet_map" {
  description = "Map of address prefix names and IPs"
  type        = map(list(string))
}
