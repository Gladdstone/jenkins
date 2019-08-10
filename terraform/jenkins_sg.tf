module "jenkins_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "2.17.0"

  name        = "jenkins-sg"
  description = "Security group for Jenkins"
  vpc_id      = "${jenkins_vpc_id}"
  egress_rules = ["all-all"]

  ingress_cidr_blocks = ["10.10.0.0/16"]

  ingress_with_cidr_blocks = [
    {
      from_port   = 8080
      to_port     = 8080
      protocol    = "tcp"
      description = "User-service ports"
      cidr_blocks = "10.10.0.0/16"
    },
    {
      from_port   = 22
      to_port     = 22
      protocol    = "ssh"
      description = "SSH"
      cidr_blocks = "10.10.0.0/16"
    }
  ]
}