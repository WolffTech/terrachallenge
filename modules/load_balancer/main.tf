resource "azurerm_public_ip" "this" {
  name                = "${var.lb_name}-pip"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_lb" "this" {
  name                = var.lb_name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "Standard"

  frontend_ip_configuration {
    name                 = "frontend-ip"
    public_ip_address_id = azurerm_public_ip.this.id
  }
}

resource "azurerm_lb_backend_address_pool" "this" {
  name            = "backend-pool"
  loadbalancer_id = azurerm_lb.this.id
}

# Health probe for web services
resource "azurerm_lb_probe" "this" {
  name                = "${var.lb_name}-probe"
  loadbalancer_id     = azurerm_lb.this.id
  protocol            = "Http"
  port                = 80
  interval_in_seconds = 15
  number_of_probes    = 2
  request_path        = "/"
}

# Load balancer rule
resource "azurerm_lb_rule" "this" {
  name                           = "${var.lb_name}-rule"
  loadbalancer_id                = azurerm_lb.this.id
  frontend_ip_configuration_name = "frontend-ip"
  protocol                       = "Tcp"
  frontend_port                  = var.frontend_port
  backend_port                   = var.backend_port
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.this.id]
  probe_id                       = azurerm_lb_probe.this.id
  enable_floating_ip             = false
  idle_timeout_in_minutes        = 4
}
