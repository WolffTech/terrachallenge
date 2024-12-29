resource "azurerm_resource_group" "this" {
  name     = "Wolff-RG-${var.prefix}"
  location = var.location
  tags     = var.tags
}

# Network

resource "azurerm_virtual_network" "this" {
  name                = "Wolff-VN-${var.prefix}"
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location
  address_space       = var.address_space
  tags                = var.tags
}

resource "azurerm_subnet" "this" {
  for_each             = var.subnet_map
  name                 = "Wolff-Subnet_${each.key}-${var.prefix}"
  resource_group_name  = azurerm_resource_group.this.name
  virtual_network_name = azurerm_virtual_network.this.name
  address_prefixes     = each.value
}

resource "azurerm_network_security_group" "this" {
  name                = "Wolff-NSG-${var.prefix}"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
}

resource "azurerm_subnet_network_security_group_association" "this" {
  subnet_id                 = azurerm_subnet.this["Web"].id
  network_security_group_id = azurerm_network_security_group.this.id
}

# Recovery Services Vault

resource "azurerm_recovery_services_vault" "this" {
  name                = "Wolff-RSV-${var.prefix}"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  sku                 = "Standard"

  soft_delete_enabled = false
}

# Linux VM

resource "azurerm_network_interface" "this" {
  name                = "Wolff-NIC_Linux-${var.prefix}"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.this["Web"].id
    private_ip_address_allocation = "Dynamic"
  }
}

# Private Key for SSH
resource "tls_private_key" "this" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "azurerm_linux_virtual_machine" "this" {
  name                = "Wolff-LinuxVM"
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location
  size                = var.vm_size
  admin_username      = var.login_name
  admin_password      = var.login_pass
  network_interface_ids = [
    azurerm_network_interface.this.id,
  ]

  admin_ssh_key {
    username   = var.login_name
    public_key = tls_private_key.this.public_key_openssh
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
}

# Windows VM

resource "azurerm_network_interface" "that" {
  name                = "Wolff-NIC_Windows-${var.prefix}"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.this["Jumpbox"].id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_windows_virtual_machine" "that" {
  name                = "Wolff-WindowsVM"
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location
  size                = var.vm_size
  admin_username      = var.login_name
  admin_password      = var.login_pass

  network_interface_ids = [
    azurerm_network_interface.that.id
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

