locals {
  aws_region = "us-east-1"
  name =  "ayo"
}

terraform {
  source = "git::https://github.com/albuquerquealdry/terraform-terragrunt-aws.git//terraform-modules/aws/network/vpc"
}

inputs = {
  name = local.name
  cidr = "10.1.0.0/16"

  azs             = ["us-east-1a", "us-east-1b"]
  private_subnets = ["10.1.1.0/24"]
  public_subnets  = ["10.1.2.0/24"]

  enable_nat_gateway = true
  enable_vpn_gateway = true

  tags = {
    Project = "ayo"
    Environment = "dev"
  }
}