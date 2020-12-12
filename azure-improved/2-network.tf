resource "azurerm_virtual_network" "demo_vnet" {
  name                = "${var.demo_name}-vnet"
  location            = var.azure_region
  address_space       = var.ip_space
  resource_group_name = azurerm_resource_group.demo_rg.name

  tags = {
    "demo" = var.demo_name
  }
}

resource "azurerm_subnet" "demo_snet" {
  name                 = "${var.demo_name}-snet"
  virtual_network_name = azurerm_virtual_network.demo_vnet.name
  resource_group_name  = azurerm_resource_group.demo_rg.name
  address_prefixes     = [var.ip_space[0]]
}