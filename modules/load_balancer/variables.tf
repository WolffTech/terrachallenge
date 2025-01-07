variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "location" {
  description = "Azure region location"
  type        = string
}

variable "lb_name" {
  description = "Name of the load balancer"
  type        = string
}

variable "frontend_port" {
  description = "Frontend port for the load balancer rule"
  type        = number
  default     = 80
}

variable "backend_port" {
  description = "Backend port for the load balancer rule"
  type        = number
  default     = 80
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
