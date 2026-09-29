
resource "aws_instance" "VM-05" {
  ami           = "ami-095f155a67469a548" 
  instance_type = "t3.micro"
  availability_zone = "ap-southeast-1b"
  tags = {
    Name = "VM-05"
  }
  provisioner "local-exec" {
    command = "echo ${self.private_ip} >> private_ip.txt"
  }

}