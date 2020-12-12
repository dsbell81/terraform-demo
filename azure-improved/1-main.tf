terraform {
  backend "azurerm" {
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "demo_rg" {
  name     = "${var.demo_name}-rg"
  location = var.azure_region

  tags = {
    "demo" = var.demo_name
  }
}