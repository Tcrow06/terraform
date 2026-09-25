# resource "aws_instance" "web" {
#   count         = 2
#   ami           = "ami-095f155a67469a548"
#   instance_type = "t3.micro"

#   tags = {
#     Name = "Server ${count.index}"
#   }
# }