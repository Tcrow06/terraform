# locals {
#   ami_ids = {
#     "aws-linux" = "ami-095f155a67469a548"
#     "ubuntu"    = "ami-0532913178263be11"
#   }
#   instance_type = "t3.micro"

#   tags = {
#     Name = "VM_ubuntu"
#     BU = "Cloud"
#   }
# }



# resource "aws_instance" "web" {
#   ami           = local.ami_ids.ubuntu
#   instance_type = local.instance_type

#   tags = local.tags
# }


# resource "aws_instance" "vm02" {
#   ami = local.ami_ids.aws-linux
#   instance_type = local.instance_type

# }
