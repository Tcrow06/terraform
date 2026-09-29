# Chưa code chính
# Tạo một dạng tài nguyên lưu file và thực hiện chạy câu lệnh terraform apply trên user thứ nhất để tạo
# định dạng tài nguyên , tiến hành khai báo xác thực của user thứ nhất

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs#environment-variables
# % export AWS_ACCESS_KEY_ID="anaccesskey"
# % export AWS_SECRET_ACCESS_KEY="asecretkey"
# % export AWS_REGION="us-west-2"
# % terraform plan



resource "aws_instance" "vm-user1" {
  ami           = "ami-095f155a67469a548"
  instance_type = "t3.micro"
  tags = {
    Name = "vm-user1"
  }
}

resource "aws_ebs_volume" "user1_volume" {
  availability_zone = "ap-southeast-1a"
  size              = 10
  tags = {
    Name = "user1-volume"
  }
}