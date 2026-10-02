resource "aws_instance" "ec2-import" {
  ami           = "ami-095f155a67469a548" 
  instance_type = "t3.micro"
}

