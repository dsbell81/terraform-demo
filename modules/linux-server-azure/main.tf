resource "azurerm_network_interface" "primary" {
  name                = "${var.hostname}-nic"
  location            = var.azure_region
  resource_group_name = var.rg_name

  ip_configuration {
    name                          = "primary"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "dynamic"
  }

  tags = var.tags
}

resource "azurerm_linux_virtual_machine" "vm" {
  name                = var.hostname
  resource_group_name = var.rg_name
  location            = var.azure_region
  size                = var.vm_size
  admin_username      = var.admin_username
  network_interface_ids = [azurerm_network_interface.primary.id]

  admin_ssh_key {
    username   = var.admin_username
    public_key = var.admin_key
  }

  os_disk {
    name                 = "${var.hostname}-disk1"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "OpenLogic"
    offer     = "CentOS"
    sku       = "7.5"
    version   = "latest"
  }

  tags = var.tags
}