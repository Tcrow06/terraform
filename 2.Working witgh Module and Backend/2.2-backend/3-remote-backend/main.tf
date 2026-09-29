terraform {
  required_version = "1.16.4"

  cloud {
    
    organization = "Dev-Thinz"

    workspaces {
      name = "Dev-P01"
    }
  }
}

resource "aws_instance" "web" {
    ami           = "ami-095f155a67469a548"
    instance_type = "t3.micro"
    tags = {
      Name = "vm"
    }
}