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

variable "vm_size" {
  description = "Size of the VM"
  type        = string
  default     = "Standard_B1s"
}

variable "login_name" {
  description = "Login username for VMs"
  type        = string
}

variable "pass_length" {
  description = "Length of randomly generated password"
  type        = number
  default     = 12
}

variable "pass_special" {
  description = "Declare if password should include special characters"
  type        = bool
  default     = true
}

variable "pass_lower" {
  description = "The minimum number of lowercase letters in the password"
  type        = number
  default     = 4
}

variable "pass_upper" {
  description = "The minimum number of uppercase letters in the password"
  type        = number
  default     = 4
}

variable "pass_numeric" {
  description = "Declare if password should include numbers"
  type        = bool
  default     = true
}

variable "pass_min_numeric" {
  description = "The minimum number of included numbers"
  type        = number
  default     = 2
}

variable "probe_protocol" {
  description = "Protocol to use for the health probe (Http or Tcp)"
  type        = string
  default     = "Http"
}

variable "probe_port" {
  description = "Port number that the health probe will use to check service availability"
  type        = number
  default     = 80
}

variable "probe_interval" {
  description = "Interval in seconds between probe attempts"
  type        = number
  default     = 15
}

variable "probe_unhealthy_threshold" {
  description = "Number of consecutive probe failures before considering the endpoint unhealthy"
  type        = number
  default     = 2
}

variable "probe_request_path" {
  description = "URI path for HTTP health probe requests"
  type        = string
  default     = "/"
}

variable "linux_machine_count" {
  description = "Amount of linux machines to create"
  type        = number
  default     = 2
}

variable "nsg_security_rules" {
  description = "List of security rules for the Network Security Group"
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

variable "backup_policy" {
  description = "Configuration for the VM backup policy"
  type = object({
    name                  = string
    timezone              = string
    frequency             = string
    time                  = string
    retention_daily_count = number
  })
}
