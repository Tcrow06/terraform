variable "ami" {
  type        = string
  description = "The AMI ID for the instance"
}
variable "type" {
  type        = string
  description = "The instance type for the instance"
}

variable "tags" {
  type = object({
    Name = string
    BU   = string
  })

} 