variable "demo_name" {
  description = "The value for the demo tag"
}

variable "azure_region" {
  description = "The azure region to use"
  default = "eastus"
}

variable "ip_space" {
  type = list
  description = "The ip address space for the enterprise network"
}

variable "demo_user" {
  description = "The linux OS admin user name"
}

variable "demo_key" {
  description = "The public ssh key for the demo user"
}