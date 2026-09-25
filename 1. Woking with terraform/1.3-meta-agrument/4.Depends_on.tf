
# # Ngoài dùng set trực tiếp hay qua for_each thì mình có thể khai báo qua local là một cái block 

# locals {
#   ami_ids = {
#     "aws-linux" = "ami-095f155a67469a548"
#     "ubuntu"    = "ami-0532913178263be11"
#   }
# }

# resource "aws_instance" "web" {
#   for_each = local.ami_ids
#   ami           = each.value
#   instance_type = "t3.micro"

#   tags = {
#     Name = "Server ${each.key} + 1"
#   }
# }


# resource "aws_security_group" "web_sg" {
#   name = "web_sg_demo"
#   description = "Security group for web servers"
  
#   # The web_security_group depends on the web_server resources 
#   depends_on = [ aws_instance.web ]
# }


# # aws_security_group.web_sg: Creating...
# # aws_instance.web["aws-linux"]: Creating...
# # aws_instance.web["ubuntu"]: Creating...
# # aws_security_group.web_sg: Creation complete after 3s [id=sg-09be4add42b323b52]
# # aws_instance.web["aws-linux"]: Still creating... [00m10s elapsed]
# # aws_instance.web["ubuntu"]: Still creating... [00m10s elapsed]
# # aws_instance.web["aws-linux"]: Creation complete after 14s [id=i-0d46d074cfd5bac7f]
# # aws_instance.web["ubuntu"]: Creation complete after 14s [id=i-021d2359c5596e4d4]

# # Nếu không dùng depends_on, 
# # Terraform sẽ tự động xác định thứ tự tạo resource dựa trên các tham chiếu giữa chúng.
# # Sẽ tự động xác định thứ tự tạo resource dựa trên các phụ thuộc ngầm định.

# # Nếu muốn tự quyết định thứ tự tạo resource, có thể sử dụng depends_on để chỉ định rõ ràng các phụ thuộc. 
# # Khi sử dụng depends_on, Terraform sẽ tạo các resource theo thứ tự mà bạn chỉ định, bất kể các phụ thuộc ngầm định.
# # aws_instance.web["aws-linux"]: Creating...
# # aws_instance.web["ubuntu"]: Creating...
# # aws_instance.web["aws-linux"]: Still creating... [00m10s elapsed]
# # aws_instance.web["ubuntu"]: Still creating... [00m10s elapsed]
# # aws_instance.web["aws-linux"]: Creation complete after 13s [id=i-003b79f44e4c938af]
# # aws_instance.web["ubuntu"]: Creation complete after 13s [id=i-0a3c264cd5d37f902]
# # aws_security_group.web_sg: Creating...
# # aws_security_group.web_sg: Creation complete after 2s [id=sg-02bb608e5d918a65d]