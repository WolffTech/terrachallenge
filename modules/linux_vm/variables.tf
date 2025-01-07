variable "vm_count" {
  description = "Number of virtual machines to create"
  type        = number
  default     = 1
}

variable "vm_name" {
  description = "Base name for the virtual machines"
  type        = string
}

variable "location" {
  description = "Azure region where resources will be created"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "vm_size" {
  description = "Size of the virtual machine"
  type        = string
}

variable "admin_username" {
  description = "Administrator username for the virtual machine"
  type        = string
}

variable "admin_password" {
  description = "Administrator password for the virtual machine"
  type        = string
  sensitive   = true
}

variable "subnet_id" {
  description = "ID of the subnet where the network interfaces will be created"
  type        = string
}

variable "backend_pool_id" {
  description = "ID of the load balancer backend pool"
  type        = string
}

variable "ssh_public_key" {
  description = "SSH public key for the virtual machine"
  type        = string
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
}

variable "recovery_vault_name" {
  description = "Name of the Recovery Services Vault for VM backup"
  type        = string
}

variable "backup_policy_id" {
  description = "ID of the backup policy to apply to the VMs"
  type        = string
}

