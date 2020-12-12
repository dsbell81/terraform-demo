provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "demo_rg" {
  name     = "demo-resources"
  location = "eastus"

  tags = {
    "demo" = "azure"
  }
}

resource "azurerm_virtual_network" "demo_vnet" {
  name                = "demo-vnet"
  location            = "eastus"
  address_space       = ["10.0.0.0/16"]
  resource_group_name = azurerm_resource_group.demo_rg.name

  tags = {
    "demo" = "azure"
  }
}

resource "azurerm_subnet" "demo_snet" {
  name                 = "demo-snet"
  virtual_network_name = azurerm_virtual_network.demo_vnet.name
  resource_group_name  = azurerm_resource_group.demo_rg.name
  address_prefixes     = ["10.0.0.0/16"]
}

resource "azurerm_network_interface" "demo01" {
  name                = "demo01-nic"
  location            = azurerm_resource_group.demo_rg.location
  resource_group_name = azurerm_resource_group.demo_rg.name

  ip_configuration {
    name                          = "primary"
    subnet_id                     = azurerm_subnet.demo_snet.id
    private_ip_address_allocation = "dynamic"
  }

  tags = {
      "demo" = "azure"
  }
}

resource "azurerm_virtual_machine" "demovm1" {
  name                  = "demo01"
  location              = azurerm_resource_group.demo_rg.location
  resource_group_name   = azurerm_resource_group.demo_rg.name
  network_interface_ids = [azurerm_network_interface.demo01.id]
  vm_size               = "Standard_B1s"

  delete_os_disk_on_termination = true

  storage_image_reference {
    publisher = "OpenLogic"
    offer     = "CentOS"
    sku       = "7.5"
    version   = "latest"
  }

  storage_os_disk {
    name              = "demo01-disk1"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  os_profile {
    computer_name  = "demo01"
    admin_username = "demouser"
  }

  os_profile_linux_config {
    disable_password_authentication = true
    ssh_keys {
      path     = "/home/demouser/.ssh/authorized_keys"
      key_data = "ssh-rsa AAAAB3NzaC1yc2EAAAABJQAAAQEAoV0uv/5nHXyYaKuamd2/lol4S0qR4wV/rDYlzHxhUkKEDkiUiqvF2FLhu8BwmPqJfGk0fSnaXv8/KvYTSUNwvKyFDPd/cqIYPdOuRx6CQHZmrzZep13bykqWN+onhSTWRIOG1cHDpNDCbCnbKVfjtfM9QJdW2HXeBlg9QH2FDXQVGtmJh6yaOvSGcIfJa/qxmJoPm6XHCo9tIlP8zJHiBSY+ikUzAcc+ehFTv+8KYfBqe39x4Ce/0HqVJL+avVZJ8Jhf9aJaDD/S9xfpFRL+2DpwOZrfkdQul6IiC2LmCMhAJntgXQjbflHVoUzNtw+WH3cgD72p+rKuAq8ua6G1zw== tf demo key"
    }
  }

  tags = {
    "demo" = "azure"
  }
}

resource "azurerm_network_interface" "demo02" {
  name                = "demo02-nic"
  location            = azurerm_resource_group.demo_rg.location
  resource_group_name = azurerm_resource_group.demo_rg.name

  ip_configuration {
    name                          = "primary"
    subnet_id                     = azurerm_subnet.demo_snet.id
    private_ip_address_allocation = "dynamic"
  }

  tags = {
      "demo" = "azure"
  }
}

resource "azurerm_linux_virtual_machine" "demovm2" {
  name                = "demo02"
  resource_group_name = azurerm_resource_group.demo_rg.name
  location            = azurerm_resource_group.demo_rg.location
  size                = "Standard_B1s"
  admin_username      = "demouser"
  network_interface_ids = [azurerm_network_interface.demo02.id]

  admin_ssh_key {
    username   = "demouser"
    public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAABJQAAAQEAoV0uv/5nHXyYaKuamd2/lol4S0qR4wV/rDYlzHxhUkKEDkiUiqvF2FLhu8BwmPqJfGk0fSnaXv8/KvYTSUNwvKyFDPd/cqIYPdOuRx6CQHZmrzZep13bykqWN+onhSTWRIOG1cHDpNDCbCnbKVfjtfM9QJdW2HXeBlg9QH2FDXQVGtmJh6yaOvSGcIfJa/qxmJoPm6XHCo9tIlP8zJHiBSY+ikUzAcc+ehFTv+8KYfBqe39x4Ce/0HqVJL+avVZJ8Jhf9aJaDD/S9xfpFRL+2DpwOZrfkdQul6IiC2LmCMhAJntgXQjbflHVoUzNtw+WH3cgD72p+rKuAq8ua6G1zw== tf demo key"
  }

  os_disk {
    name                 = "demo02-disk1"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "OpenLogic"
    offer     = "CentOS"
    sku       = "7.5"
    version   = "latest"
  }

  tags = {
    "demo" = "azure"
  }
}