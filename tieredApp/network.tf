resource "aws_vpc" "demovpc" {
  cidr_block = local.ip_space

  tags = local.tags
}

resource "aws_subnet" "demosubnet" {
  vpc_id     = aws_vpc.demovpc.id
  cidr_block = local.ip_space

  tags = local.tags
}

resource "azurerm_virtual_network" "demo_vnet" {
  name                = "${terraform.workspace}-tieredapp-vnet"
  location            = local.azure_region
  address_space       = [local.ip_space]
  resource_group_name = azurerm_resource_group.demo_rg.name

  tags = local.tags
}

resource "azurerm_subnet" "demo_snet" {
  name                 = "tieredapp-snet"
  virtual_network_name = azurerm_virtual_network.demo_vnet.name
  resource_group_name  = azurerm_resource_group.demo_rg.name
  address_prefixes     = [local.ip_space]
}