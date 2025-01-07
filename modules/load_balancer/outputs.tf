output "lb_id" {
  description = "The ID of the Load Balancer"
  value       = azurerm_lb.this.id
}

output "backend_pool_id" {
  description = "The ID of the Backend Address Pool"
  value       = azurerm_lb_backend_address_pool.this.id
}

output "probe_id" {
  description = "The ID of the health probe"
  value       = azurerm_lb_probe.this.id
}
