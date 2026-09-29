# File chứ mô tả kết nối với standard backend
terraform {
  backend "s3" {
    bucket = "demo-backend-s3-2026-09-28"
    key    = "state/terraform.tfstate"  // Key sẽ là đường dẫn thư mục trên bitbucket nơi mà chúng ta sẽ thực hiện lưu file state
    region = "ap-southeast-1"
    encrypt = true
    dynamodb_table = "terraform-lock"

  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
      }
  }
}


provider "aws" {
  region = "ap-southeast-1"
  
}