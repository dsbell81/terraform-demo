variable "app_user" {
  description = "The app admin user name"
}

variable "app_key" {
  description = "The public ssh key for the app user"
}

variable "aws_subnet_id" {
  description = "amazon subnet id for the web tier"
}

variable "azure_subnet_id" {
  description = "azure subnet id for the data tier"
}

variable "azure_rg_name" {
  description = "azure subnet id for the data tier"
}

variable "tags" {
  type = map
  description = "List of tags for vm"
  default = {}
}