# Naming convention for resources are as follows
# Owner-ResourceType-Project

prefix   = "TerraChallenge"
location = "eastus"

# Tags

tags = {
  Environment = "Dev"
  Owner       = "Nick Wolff"
  Project     = "TerraChallenge"
  Team        = "IOC Engineering"
  Department  = "Managed Services"
  Version     = "Checkpoint4"
  Deployment  = "Terraform"
}

# Network

address_space = ["10.0.0.0/16"]

subnet_map = {
  "Web"     = ["10.0.1.0/24"]
  "Data"    = ["10.0.2.0/24"]
  "Jumpbox" = ["10.0.3.0/24"]
}

# Health Probe

probe_protocol            = "Http"
probe_port                = 80
probe_interval            = 15
probe_unhealthy_threshold = 2
probe_request_path         = "/"

# VMs

vm_size    = "Standard_B1ms"
login_name = "adminuser"
linux_machine_count = 2
