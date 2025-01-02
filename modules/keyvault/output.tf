output "key_vault_id" {
  value       = azurerm_key_vault.this.id
  description = "The ID of the Key Vault"
}

output "key_vault_name" {
  value       = azurerm_key_vault.this.name
  description = "The name of the Key Vault"
}

output "key_vault_uri" {
  value       = azurerm_key_vault.this.vault_uri
  description = "The URI of the Key Vault"
}

output "key_vault_location" {
  value = azurerm_key_vault.this.location
  description = "The location of the Key Vault"
}
