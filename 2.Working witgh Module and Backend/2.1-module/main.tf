terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

module "VPC-Demo" {
  source = "./VPC"
}


module "vpc-01" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.8.1"
}
