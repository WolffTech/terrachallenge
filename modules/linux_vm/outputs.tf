output "vm_ids" {
  description = "List of IDs of the created virtual machines"
  value       = azurerm_linux_virtual_machine.this[*].id
}

output "vm_names" {
  description = "List of names of the created virtual machines"
  value       = azurerm_linux_virtual_machine.this[*].name
}

output "nic_ids" {
  description = "List of IDs of the created network interfaces"
  value       = azurerm_network_interface.this[*].id
}

output "private_ip_addresses" {
  description = "List of private IP addresses assigned to the network interfaces"
  value       = azurerm_network_interface.this[*].private_ip_address
}

