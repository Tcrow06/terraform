# resource "aws_instance" "web" {
#   for_each = local.ami_ids
#   ami           = each.value
#   instance_type = "t3.micro"

#   tags = {
#     Name = "Server ${each.key} + 1"
#   }
# }

# # Ngoài dùng set trực tiếp hay qua for_each thì mình có thể khai báo qua local là một cái block 

# locals {
#   ami_ids = {
#     "aws-linux" = "ami-095f155a67469a548"
#     "ubuntu"    = "ami-0532913178263be11"
#   }
# }