# Generals

prefix   = "terrachallenge"
location = "eastus"

# Tags

tags = {
  Environment = "Dev"
  Owner       = "Nick Wolff"
  Project     = "TerraChallenge"
  Team        = "IOC Enginnering"
  Department  = "Managed Services"
  Version     = "Checkpoint1"
  Deployment  = "Terraform"
}

# Network

address_space = ["10.0.0.0/16"]

cidrs = {
  "Web" = "10.0.1.0/24"
  "Data" = "10.0.2.0/24"
  "Jumpbox" = "10.0.3.0/24"
}

nsg_rules = [{
  name = "AllowSSH"
  priority = 100
  direction = "Inbound"
  access = "Allow"
  protocol = "Tcp"
  source_port_range = "*"
  destination_port_range = "22"
  source_address_prefix = "*"
  destination_address_prefix = "*"
}]
