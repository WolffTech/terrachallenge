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
  Version     = "Checkpoint1"
  Deployment  = "Terraform"
}

# Network

address_space = ["10.0.0.0/16"]

subnet_map = {
  "Web"     = ["10.0.1.0/24"]
  "Data"    = ["10.0.2.0/24"]
  "Jumpbox" = ["10.0.3.0/24"]
}

# VMs

vm_size    = "Standard_B1ms"
login_name = "adminuser"
login_pass = "TempPassword!"
