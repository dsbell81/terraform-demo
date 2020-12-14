terraform {
  backend "azurerm" {
  }
}

provider "aws" {
    profile = "default"
    region = "us-east-2"
}

provider "azurerm" {
  features {}
}

locals {
  ip_space = "10.0.0.0/16"
  tags          = {
    "demo" = "tieredApp"
    "environment" = terraform.workspace
  }
  azure_region = "eastus"
  username = "appadmin"
  ssh_key = "ssh-rsa AAAAB3NzaC1yc2EAAAABJQAAAQEAoV0uv/5nHXyYaKuamd2/lol4S0qR4wV/rDYlzHxhUkKEDkiUiqvF2FLhu8BwmPqJfGk0fSnaXv8/KvYTSUNwvKyFDPd/cqIYPdOuRx6CQHZmrzZep13bykqWN+onhSTWRIOG1cHDpNDCbCnbKVfjtfM9QJdW2HXeBlg9QH2FDXQVGtmJh6yaOvSGcIfJa/qxmJoPm6XHCo9tIlP8zJHiBSY+ikUzAcc+ehFTv+8KYfBqe39x4Ce/0HqVJL+avVZJ8Jhf9aJaDD/S9xfpFRL+2DpwOZrfkdQul6IiC2LmCMhAJntgXQjbflHVoUzNtw+WH3cgD72p+rKuAq8ua6G1zw== tf demo key"
}

resource "azurerm_resource_group" "demo_rg" {
  name     = "${terraform.workspace}-tieredapp-rg"
  location = local.azure_region

  tags = local.tags
}

module myapp {
    source              = "../modules/two-tier-app-multi"
    app_user            = local.username
    app_key             = local.ssh_key
    aws_subnet_id       = aws_subnet.demosubnet.id
    azure_subnet_id     = azurerm_subnet.demo_snet.id
    azure_rg_name       = azurerm_resource_group.demo_rg.name
    tags                = local.tags
}