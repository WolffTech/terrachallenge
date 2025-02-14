output "id" {
  value       = azurerm_key_vault.this.id
  description = "The ID of the Key Vault"
}

output "name" {
  value       = azurerm_key_vault.this.name
  description = "The name of the Key Vault"
}

output "uri" {
  value       = azurerm_key_vault.this.vault_uri
  description = "The URI of the Key Vault"
}

output "location" {
  value = azurerm_key_vault.this.location
  description = "The location of the Key Vault"
}
