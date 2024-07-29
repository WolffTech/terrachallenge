variable "base_name" {
  description = "The base of the name for the resource group"
  type = string
}

variable "location" {
  description = "The location for the resource group"
  type = string
}

variable "tags" {
  description = "Tags to put on the resource group"
  type = map(string)
  default = {}
}
