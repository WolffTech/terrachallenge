# modules/linux_vm/main.tf

resource "azurerm_network_interface" "this" {
  count               = var.vm_count
  name                = "${var.vm_name}-nic-${count.index + 1}"
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_network_interface_backend_address_pool_association" "this" {
  count                   = var.vm_count
  network_interface_id    = azurerm_network_interface.this[count.index].id
  ip_configuration_name   = "internal"
  backend_address_pool_id = var.backend_pool_id
}

resource "azurerm_linux_virtual_machine" "this" {
  count               = var.vm_count
  name                = "${var.vm_name}-${count.index + 1}"
  resource_group_name = var.resource_group_name
  location            = var.location
  size                = var.vm_size
  admin_username      = var.admin_username
  admin_password      = var.admin_password
  network_interface_ids = [
    azurerm_network_interface.this[count.index].id,
  ]

  admin_ssh_key {
    username   = var.admin_username
    public_key = var.ssh_public_key
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

  custom_data = base64encode(<<-EOF
    #!/bin/bash
    apt-get update
    apt-get install -y nginx
    systemctl enable nginx
    systemctl start nginx
    EOF
  )

  tags = var.tags
}

resource "azurerm_backup_protected_vm" "this" {
  count               = var.vm_count
  resource_group_name = var.resource_group_name
  recovery_vault_name = var.recovery_vault_name
  backup_policy_id    = var.backup_policy_id
  source_vm_id        = azurerm_linux_virtual_machine.this[count.index].id
}

