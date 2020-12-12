variable "rg_name" {
  description = "The name of the Resource Group where the linux server resources will be created"
}

variable "azure_region" {
  description = "The azure region where the vm will be created"
  default = "eastus"
}

variable "subnet_id" {
  description = "The Subnet ID which the linux server's NIC should be created in"
}

variable "hostname" {
  description = "The hostname for the linux server"
}

variable "vm_size" {
  description = "The size for the vm"
  default     = "Standard_B1s"
}

variable "admin_username" {
  description = "The user name of the admin user for the vm"
}

variable "admin_key" {
  description = "The public key for the admin user for the vm"
}

variable "tags" {
  type = map
  description = "List of tags for vm"
  default = {}
}