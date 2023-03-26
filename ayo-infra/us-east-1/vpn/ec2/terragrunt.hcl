locals {
  vpc_id                 = "vpc-0b429e01d0b9c1b29"
  ami                    = "ami-007855ac798b5175e"
  instance_type          = "t3.medium"
  key_name               = "chave"
  monitoring             = false
  subnet_id              = "subnet-042cc5b2dc46ca87e"
}

remote_state {
  backend = "s3"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite"
  }
  config = {
    bucket         = "ayo-state-666"
    key            = "vpc/ec2/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "my-lock-table"
  }
}

terraform {
  source = "git::https://github.com/albuquerquealdry/terraform-terragrunt-aws.git//terraform-modules/aws/computing/ec2"
}

inputs = {

  ami                    = local.ami
  instance_type          = local.instance_type
  key_name               = local.key_name
  monitoring             = local.monitoring
  subnet_id              = local.subnet_id
  user_data              = "${file("../bash_scripts/vpnuserdata.sh")}"
  tags                   = {
    Project = "ayo"
    Environment = "dev"
  }
}