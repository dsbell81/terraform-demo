provider "aws" {
    profile = "default"
    region = "us-east-2"
}

resource "aws_vpc" "demovpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    "demo" = "aws"
  }
}

resource "aws_subnet" "demosubnet" {
  vpc_id     = aws_vpc.demovpc.id
  cidr_block = "10.0.0.0/16"

  tags = {
    "demo" = "aws"
  }
}

resource "aws_key_pair" "demouser_key" {
  key_name   = "demouser-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAABJQAAAQEAoV0uv/5nHXyYaKuamd2/lol4S0qR4wV/rDYlzHxhUkKEDkiUiqvF2FLhu8BwmPqJfGk0fSnaXv8/KvYTSUNwvKyFDPd/cqIYPdOuRx6CQHZmrzZep13bykqWN+onhSTWRIOG1cHDpNDCbCnbKVfjtfM9QJdW2HXeBlg9QH2FDXQVGtmJh6yaOvSGcIfJa/qxmJoPm6XHCo9tIlP8zJHiBSY+ikUzAcc+ehFTv+8KYfBqe39x4Ce/0HqVJL+avVZJ8Jhf9aJaDD/S9xfpFRL+2DpwOZrfkdQul6IiC2LmCMhAJntgXQjbflHVoUzNtw+WH3cgD72p+rKuAq8ua6G1zw== tf demo key"
}

resource "aws_instance" "demo1" {
  ami           = "ami-00f8e2c955f7ffa9b" #CentOS 7.9 us-east2
  instance_type = "t2.micro"
  subnet_id = aws_subnet.demosubnet.id
  key_name = aws_key_pair.demouser_key.key_name

  tags = {
    "demo" = "aws"
  }
}

resource "aws_instance" "demo2" {
  ami           = "ami-00f8e2c955f7ffa9b" #CentOS 7.9 us-east2
  instance_type = "t2.micro"
  subnet_id = aws_subnet.demosubnet.id
  key_name = aws_key_pair.demouser_key.key_name

  tags = {
    "demo" = "aws"
  }
}