provider "aws" {
  region = "ap-southeast-1"
}

resource "aws_key_pair" "demo" {
  key_name   = "demo-key"
  public_key = file("../keypair/keypair.pub")
}
resource "aws_security_group" "demo" {
  name        = "demo-sg"
  description = "Demo security group"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "demo" {
  ami           = "ami-095f155a67469a548"
  instance_type = "t3.micro"
  key_name      = aws_key_pair.demo.key_name
  vpc_security_group_ids = [aws_security_group.demo.id]
  tags = {
    Name = "demo-instance"
  }
}