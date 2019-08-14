provider "aws" {
  region = "us-east-1"
}

module "jenkins_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "2.17.0"

  name        = "jenkins-sg"
  description = "Security group for Jenkins"
  vpc_id      = "${module.jenkins_vpc.vpc_id}"
  egress_rules = ["all-all"]

  ingress_cidr_blocks = ["10.10.0.0/16"]

  ingress_with_cidr_blocks = [
    {
      from_port   = 8080
      to_port     = 8080
      protocol    = "tcp"
      description = "User-service ports"
      cidr_blocks = "10.10.0.0/16"
    }
  ]
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

  enable_ec2_endpoint              = true
  ec2_endpoint_private_dns_enabled = true
  ec2_endpoint_security_group_ids  = ["${aws_security_group.jenkins_sg.this_security_group_id}"]

  tags = {
    Launched = "${timestamp()}"
    Terraform = "true"
    Environment = "dev"
  }
}