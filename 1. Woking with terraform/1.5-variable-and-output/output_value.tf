# output "instance_ami" {
#   value =  aws_instance.web.ami
# }

# output "instance_state" {
#   value = aws_instance.web.instance_state
#   description = "The current state of the web instance"
# }

# output "Public_ip" {
#   value = aws_instance.web.public_ip
#   description = "The public IP address of the web instance"

#   # Nếu là true thì giá trị này sẽ được coi là nhạy cảm và sẽ không hiển thị trong đầu ra mặc định của Terraform
#   sensitive = true
# }