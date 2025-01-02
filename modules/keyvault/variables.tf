variable "key_vault_name" {
  type        = string
  description = "Name of the Key Vault"
}

variable "location" {
  type        = string
  description = "Azure region where the Key Vault will be created"
}

variable "resource_group_name" {
  type        = string
  description = "Name of the resource group"
}

variable "tenant_id" {
  type        = string
  description = "Azure AD tenant ID"
}

variable "object_id" {
  type        = string
  description = "Object ID of the service principal or user"
}

variable "enabled_for_disk_encryption" {
  type        = bool
  description = "Enable Key Vault for disk encryption"
  default     = true
}

variable "soft_delete_retention_days" {
  type        = number
  description = "Soft delete retention days"
  default     = 7
}

variable "purge_protection_enabled" {
  type        = bool
  description = "Enable purge protection"
  default     = false
}

variable "sku_name" {
  type        = string
  description = "SKU name for the Key Vault"
  default     = "standard"
}
