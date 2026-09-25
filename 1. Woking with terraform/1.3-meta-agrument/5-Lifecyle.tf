# Có 4 loại lifecycle argument trong Terraform
# 1. create_before_destroy: Tạo resource mới trước khi xóa resource cũ.
# resource "aws_instance" "web" {
#   count         = 1
#   ami           = "ami-095f155a67469a548"
#   instance_type = "t3.micro"
#   # availability_zone = "ap-southeast-1a"
#   availability_zone = "ap-southeast-1b"

#   tags = {
#     Name = "Server ${count.index}"
#   }

#   lifecycle {
#     create_before_destroy = true
#   }
# }

# Theo logic thông thường khi ta thay đổi code cấu hình của terraform trên một dạng tài nguyên thì
# Tài nguyên cũ sẽ được xóa đi và sau khi tài nguyên được xóa hoàn toàn thì tài nguyên mới mới bắt đầu khỏi tạo
# Như vậy sẽ có thời gian chết giữa xóa tài nguyên cũ và tạo tài nguyên mới và nếu tài nguyên đang phục vụ cho một
# Ứng dụng nào đó thì sẽ xảy ra thời gian downtime 
# Thêm create_before_destroy vào lifecycle sẽ giúp giảm thời gian downtime bằng cách tạo tài nguyên mới trước khi xóa tài nguyên cũ.
# Plan: 1 to add, 0 to change, 1 to destroy.
# aws_instance.web[0]: Creating...
# aws_instance.web[0]: Still creating... [00m10s elapsed]
# aws_instance.web[0]: Creation complete after 13s [id=i-0ab312849bec18660]
# aws_instance.web[0] (deposed object de388228): Destroying... [id=i-0f0a940e460122251]
# aws_instance.web[0]: Still destroying... [id=i-0f0a940e460122251, 00m10s elapsed]
# aws_instance.web[0]: Still destroying... [id=i-0f0a940e460122251, 00m20s elapsed]
# aws_instance.web[0]: Destruction complete after 30s

# Là sẽ tạo xong mới tiến hành xóa


# 2. prevent_destroy: Ngăn không cho resource bị xóa.

# resource "aws_instance" "web1" {
#   count         = 1
#   ami           = "ami-095f155a67469a548"
#   instance_type = "t3.micro"
#   # availability_zone = "ap-southeast-1a"
#   availability_zone = "ap-southeast-1b"

#   tags = {
#     Name = "Server ${count.index}"
#   }

#   # lifecycle {
#   #   prevent_destroy = true
#   # }
# }

#  Khi prevent_destroy được bật, nếu bạn cố gắng xóa resource này, 
# Terraform sẽ báo lỗi và không thực hiện xóa.
# Plan: 0 to add, 0 to change, 1 to destroy.
# ╷
# │ Error: Instance cannot be destroyed
# │ 
# │   on 5-Lifecyle.tf line 38:
# │   38: resource "aws_instance" "web1" {
# │ 
# │ Resource aws_instance.web1[0] has lifecycle.prevent_destroy set, but the plan calls for this resource
# │ to be destroyed. To avoid this error and continue with the plan, either disable
# │ lifecycle.prevent_destroy or reduce the scope of the plan using the -target option.

# 3. ignore_changes: Bỏ qua các thay đổi của các thuộc tính cụ thể.

# resource "aws_instance" "web2" {
#   count         = 1
#   ami           = "ami-095f155a67469a548"
#   instance_type = "t3.micro"
#   # availability_zone = "ap-southeast-1a"
#   availability_zone = "ap-southeast-1b"

#   tags = {
#     Name = "Server ${count.index} ${timestamp()}"
#   }

#   lifecycle {
#     ignore_changes = [ 
#       tags  
#     ]
#   }
# }

# Giả sử hàm timestamp() sẽ luôn thay đổi mỗi khi chạy plan, 
# điều này sẽ kích hoạt việc tạo lại resource nếu được sử dụng trong thuộc tính tags.
# Ignore_changes sẽ giúp Terraform bỏ qua các thay đổi này và không tạo lại resource.


# 4. replace_triggered_by: Thay thế resource khi một resource khác thay đổi.
resource "aws_security_group" "web2_sg" {
  name        = "web2_sg"
  description = "Security group for web2 instance"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "web2" {
  count         = 1
  ami           = "ami-095f155a67469a548"
  instance_type = "t3.micro"
  # availability_zone = "ap-southeast-1a"
  availability_zone = "ap-southeast-1b"
  security_groups = [aws_security_group.web2_sg.name]

  tags = {
    Name = "Server ${count.index}"
  }

  lifecycle {
    replace_triggered_by = [
      aws_security_group.web2_sg
    ]
  }
}

# Theo logic thông thường thì khi thay đổi code trên block code nào thì chỉ những tài nguyên trên block đó sẽ bị ảnh hưởng.
# VD thay đổi code trên security group sẽ chỉ ảnh hưởng đến security group đó, không ảnh hưởng đến instance web2.
# Plan: 0 to add, 1 to change, 0 to destroy.
# aws_security_group.web2_sg: Modifying... [id=sg-0f0606ad126aa004f]
# aws_security_group.web2_sg: Modifications complete after 2s [id=sg-0f0606ad126aa004f]

# Khi thêm replace_triggered_by trỏ đến aws_security_group.web2_sg, 
# bất kỳ thay đổi nào trên security group này cũng sẽ kích hoạt việc thay thế instance web2.  

# Plan: 1 to add, 1 to change, 1 to destroy.
# aws_instance.web2[0]: Destroying... [id=i-0554871785fcc721d]
# aws_instance.web2[0]: Still destroying... [id=i-0554871785fcc721d, 00m10s elapsed]
# aws_instance.web2[0]: Destruction complete after 20s
# aws_security_group.web2_sg: Modifying... [id=sg-0f0606ad126aa004f]
# aws_security_group.web2_sg: Modifications complete after 1s [id=sg-0f0606ad126aa004f]
# aws_instance.web2[0]: Creating...
# aws_instance.web2[0]: Still creating... [00m10s elapsed]
# aws_instance.web2[0]: Creation complete after 13s [id=i-0010511496007954a]

