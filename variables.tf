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
