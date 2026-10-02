resource "aws_key_pair" "ssh-key" {
  key_name   = "sshkey"
  public_key = file("sshkey.pub")
}

resource "aws_instance" "VM-05" {
  ami                    = "ami-095f155a67469a548"
  instance_type          = "t3.micro"
  availability_zone      = "ap-southeast-1a"
  vpc_security_group_ids = ["sg-01a9e38a91299fe24"]
  key_name               = aws_key_pair.ssh-key.key_name
  subnet_id              = "subnet-014bb35a2e705d55c"
  associate_public_ip_address = true
  tags = {
    Name = "VM-05"
  }


  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = file("sshkey")
    host        = self.public_ip
    timeout     = "5m"
  }


  provisioner "local-exec" {
    
    command = "echo ${self.public_ip} >> public_ip.txt"
    # command = "ansible-playbook -i ${self.public_ip}, --private-key sshkey httpd.yaml"
    
  }
}
