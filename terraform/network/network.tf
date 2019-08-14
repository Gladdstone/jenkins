provider "aws" {
  region = "us-east-1"
}

data "aws_security_group" "jenkins_sg" {
  name   = "default"
  vpc_id = "${module.jenkins_vpc.vpc_id}"
}

module "jenkins_vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "1.67.0"

  name = "jenkins"
  cidr = "10.0.0.0/16"

  azs             = ["us-east-1a"]
  private_subnets = ["10.0.1.0/24"]
  public_subnets  = ["10.0.101.0/24"]

  enable_nat_gateway = true
  enable_vpn_gateway = true

  tags = {
    Launched = "${timestamp()}"
    Terraform = "true"
    Environment = "dev"
  }
}