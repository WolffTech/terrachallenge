module "resource_group" {
  source   = "./modules/rg"
  name     = "Wolff-RG-${var.prefix}"
  location = var.location
  tags     = var.tags
}

# Network

resource "azurerm_virtual_network" "vnet" {
  name                = "Wolff-VN-${var.prefix}"
  resource_group_name = module.resource_group.name
  location            = module.resource_group.location
  address_space       = var.address_space
  tags                = var.tags
}

resource "azurerm_subnet" "subnet" {
  for_each             = var.subnet_map
  name                 = "Wolff-Subnet_${each.key}-${var.prefix}"
  resource_group_name  = module.resource_group.name
  virtual_network_name = module.resource_group.location
  address_prefixes     = each.value
}

resource "azurerm_network_security_group" "nsg" {
  name                = "Wolff-NSG-${var.prefix}"
  location            = module.resource_group.location
  resource_group_name = module.resource_group.name
  tags                = var.tags
}

resource "azurerm_subnet_network_security_group_association" "nsga" {
  subnet_id                 = azurerm_subnet.subnet["Web"].id
  network_security_group_id = azurerm_network_security_group.nsg.id

}

# Key Vault

module "key_vault" {
  source                      = "./modules/keyvault"
  name                        = "Wolff-KV-${var.prefix}"
  location                    = var.location
  resource_group_name         = module.resource_group.name
  enabled_for_disk_encryption = true
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false
  sku_name                    = "standard"
}

# Recovery Services Vault

resource "azurerm_recovery_services_vault" "rsv" {
  name                = "Wolff-RSV-${var.prefix}"
  location            = module.resource_group.location
  resource_group_name = module.resource_group.name
  sku                 = "Standard"

  soft_delete_enabled = false

  tags = var.tags

}

# Backup Policy

resource "azurerm_backup_policy_vm" "abp" {
  name                = "tfex-recovery-vault-policy"
  resource_group_name = module.resource_group.name
  recovery_vault_name = azurerm_recovery_services_vault.rsv.name

  timezone = "UTC"

  backup {
    frequency = "Daily"
    time      = "23:00"
  }

  retention_daily {
    count = 1
  }
}

# Random Password Generator

resource "random_password" "random_password" {
  length    = var.pass_length
  special   = var.pass_special
  min_lower = var.pass_lower
  min_upper = var.pass_upper
  numeric   = var.pass_numeric
}

# Load Balancer

module "load_balancer" {
  source = "./modules/load_balancer"
  lb_name = "Wolff-LB-${var.prefix}"
  resource_group_name = module.resource_group.name
  location = module.resource_group.location
  frontend_port = 80
  backend_port = 80
}

# Linux VM

resource "azurerm_key_vault_secret" "admin_password_linux" {
  name         = "adminpasswordlinux"
  value        = random_password.random_password.result
  key_vault_id = module.key_vault.id
  depends_on   = [module.key_vault]
}

resource "azurerm_network_interface" "nic_linuxvm_1" {
  name                = "Wolff-NIC_Linux-${var.prefix}"
  location            = module.resource_group.location
  resource_group_name = module.resource_group.name
  tags                = var.tags


  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet["Web"].id
    private_ip_address_allocation = "Dynamic"
  }
}

# Private Key for SSH
resource "tls_private_key" "tlspk" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "azurerm_linux_virtual_machine" "linuxvm_1" {
  name                = "Wolff-LinuxVM"
  resource_group_name = module.resource_group.name
  location            = module.resource_group.location
  size                = var.vm_size
  admin_username      = var.login_name
  admin_password      = azurerm_key_vault_secret.admin_password_linux.value
  network_interface_ids = [
    azurerm_network_interface.nic_linuxvm_1.id,
  ]

  admin_ssh_key {
    username   = var.login_name
    public_key = tls_private_key.tlspk.public_key_openssh
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }

  tags = var.tags
}

resource "azurerm_backup_protected_vm" "pvm_linuxvm_1" {
  resource_group_name = module.resource_group.name
  recovery_vault_name = azurerm_recovery_services_vault.rsv.name
  backup_policy_id    = azurerm_backup_policy_vm.abp.id
}

# Windows VM

resource "azurerm_key_vault_secret" "admin_password_windows" {
  name         = "adminpasswordwindows"
  value        = random_password.random_password.result
  key_vault_id = module.key_vault.id
  depends_on   = [module.key_vault]
}

resource "azurerm_network_interface" "nic_windowsvm_1" {
  name                = "Wolff-NIC_Windows-${var.prefix}"
  location            = module.resource_group.location
  resource_group_name = module.resource_group.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet["Jumpbox"].id
    private_ip_address_allocation = "Dynamic"
  }

  tags = var.tags
}

resource "azurerm_windows_virtual_machine" "windowsvm_1" {
  name                = "Wolff-WindowsVM"
  resource_group_name = module.resource_group.name
  location            = module.resource_group.location
  size                = var.vm_size
  admin_username      = var.login_name
  admin_password      = azurerm_key_vault_secret.admin_password_windows.value

  network_interface_ids = [
    azurerm_network_interface.nic_windowsvm_1.id
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }

  tags = var.tags
}

resource "azurerm_backup_protected_vm" "pvm_windowsvm_1" {
  resource_group_name = module.resource_group.name
  recovery_vault_name = azurerm_recovery_services_vault.rsv.name
  backup_policy_id    = azurerm_backup_policy_vm.abp.id
}

