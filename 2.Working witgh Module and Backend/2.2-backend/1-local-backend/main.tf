terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = ">=5.0.0"
    }
  }
}

provider "aws" {
  region = "ap-southeast-1"
}

resource "aws_instance" "web" {
  ami = "ami-095f155a67469a548"
  instance_type = "t3.micro"
  tags = {
    Name = "Server"
  }
}