# # Khai báo 2 provider khác nhau nên để sử dụng 1 provider cụ thể trong resource, 
# # ta cần dùng alias ( khai báo đối số trong provider)


# provider "aws" {
#   alias  = "singapore"
#   region = "ap-southeast-1"
# }

# provider "aws" {
#   alias  = "virginia"
#   region = "us-east-1"
# }

# resource "aws_instance" "web" {
#   provider      = aws.virginia
#   ami           = "ami-0fef201115eefe936"
#   instance_type = "t3.micro"
#   tags = {
#     Name = "Web Server"
#   }
# }
