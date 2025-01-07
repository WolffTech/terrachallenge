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
  type    = string
  default = "Http"
}

variable "probe_port" {
  type    = number
  default = 80
}

variable "probe_interval" {
  type    = number
  default = 15
}

variable "probe_unhealthy_threshold" {
  type    = number
  default = 2
}

variable "probe_request_path" {
  type    = string
  default = "/"
}
