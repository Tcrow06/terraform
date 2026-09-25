# https://registry.terraform.io/providers/hashicorp/aws/latest/docs

data "aws_ami" "ubuntu_ami" {
  most_recent = true
  filter {
    name = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
  filter {
    name = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["amazon"]
}

output "ami-ubuntu" {
  value = data.aws_ami.ubuntu_ami.id
}


resource "aws_instance" "ubuntu_instance" {
  ami = data.aws_ami.ubuntu_ami.id
  instance_type = "t3.micro"

  tags = {
    Name = "VM01"
  }

}

# Giả định đang tồn tại 1 instance với tên là VM01 và mong tạo ra một con VM với ami tương tự với con VM01
# Chúng ta sẽ sử dụng filter để tìm instance với tên là VM01 và lấy ami của nó

data "aws_instance" "find-instance" {
  filter {
    name = "tag:Name"
    values = ["VM01"]
  }
}

output "ubuntu_instance" {
  value = data.aws_instance.find-instance.public_ip
}

# Tạo con VM02 cùng sử dụng ami của VM01
resource "aws_instance" "vm02" {
  ami = data.aws_instance.find-instance.ami
  instance_type = "t3.micro"
  tags = {
    Name = "VM02"
  }
}