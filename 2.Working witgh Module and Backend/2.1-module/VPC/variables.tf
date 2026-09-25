variable "vpc_cidr_block" {
  type        = string
  description = "The CIDR block for the VPC"
  default = "10.0.0.0/16"
}
variable "vpc_name" {
  description = "Name of the VPC"
  type = string
  default = "Main_vpc"
}

variable "public_subnet1_cidr_block" {
  description = "The CIDR block for the first public subnet"
  type = string
  default = "10.0.1.0/24"
}
variable "public_subnet1_name" {
  description = "The name of the first public subnet"
  type = string
  default = "Public_Subnet_1"
}
variable "public_subnet1_az" {
  description = "The Availability Zone for the frist public subnet"
  type = string
  default = "ap-southeast-1b"
}

variable "public_subnet2_cidr_block" {
  description = "The CIDR block for the second public subnet"
  type = string
  default = "10.0.2.0/24"
}
variable "public_subnet2_name" {
  description = "The name of the second public subnet"
  type = string
  default = "Public_Subnet_2"
}
variable "public_subnet2_az" {
  description = "The Availability Zone for the second public subnet"
  type = string
  default = "ap-southeast-1b"
}

variable "private_subnet1_cidr_block" {
  description = "The CIDR block for the first private subnet"
  type = string
  default = "10.0.3.0/24"
}
variable "private_subnet1_name" {
  description = "The name of the first private subnet"
  type = string
  default = "Private_Subnet_1"
}
variable "private_subnet1_az" {
  description = "The Availability Zone for the first private subnet"
  type = string
  default = "ap-southeast-1b"
}

variable "private_subnet2_cidr_block" {
  description = "The CIDR block for the second private subnet"
  type = string
  default = "10.0.4.0/24"
}
variable "private_subnet2_name" {
  description = "The name of the second private subnet"
  type = string
  default = "Private_Subnet_2"
}
variable "private_subnet2_az" {
  description = "The Availability Zone for the second private subnet"
  type = string
  default = "ap-southeast-1b"
}

