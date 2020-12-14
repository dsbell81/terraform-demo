#webservers in aws
resource "aws_key_pair" "app_key" {
  key_name   = "app-key"
  public_key = var.app_key
}

resource "aws_instance" "demo" {
  count         = terraform.workspace == "prod" ? 2 : 1
  ami           = "ami-00f8e2c955f7ffa9b" #CentOS 7.9 us-east2
  instance_type = "t2.micro"
  subnet_id     = var.aws_subnet_id
  key_name      = aws_key_pair.app_key.key_name

  tags = var.tags
}

#datastore in azure
module server1 {
    source          = "../linux-server-azure"
    rg_name         = var.azure_rg_name
    subnet_id       = var.azure_subnet_id
    hostname        = "${terraform.workspace}-appdb01"
    admin_username  = var.app_user
    admin_key       = var.app_key
    tags            = var.tags
}