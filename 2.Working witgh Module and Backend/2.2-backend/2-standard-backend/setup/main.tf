terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = ">=5.0.0"
    }
  }
}


provider "aws" {
  region = "ap-southeast-1"
}
resource "aws_s3_bucket" "s3_bucket"{
  bucket = "demo-backend-s3-${formatdate("YYYY-MM-DD", timestamp())}"
}

resource "aws_dynamodb_table" "terraform_lock" {
  name = "terraform-lock"
  billing_mode = "PAY_PER_REQUEST"
  hash_key = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}

