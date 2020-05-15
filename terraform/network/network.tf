provider "aws" {
  region = var.availability_zone
}

resource "aws_security_group" "jenkins_sg" {
  name        = "jenkins-sg"
  description = "Security group for Jenkins"
  vpc_id      = aws_vpc.jenkins_vpc.id

  ingress {
    description = "TLS from VPC"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Launched = timestamp()
    Terraform = "true"
    Environment = var.environment
  }
}

resource "aws_vpc" "jenkins_vpc" {
  cidr_block = var.cidr_jenkins_vpc

  tags = {
    Name = "jenkins-vpc"
    Launched = timestamp()
    Terraform = "true"
    Environment = var.environment
  }
}

resource "aws_internet_gateway" "jenkins_nat" {
  vpc_id = aws_vpc.jenkins_vpc.id

  tags = {
    Terraform = "true"
    Environment = var.environment
  }
}

resource "aws_subnet" "jenkins_subnet" {
  vpc_id = aws_vpc.jenkins_vpc.id

  cidr_block = var.cidr_jenkins_subnet
  map_public_ip_on_launch = "true"
  availability_zone = var.availability_zone

  tags = {
    Terraform = "true"
    Environment = var.environment
  }
}

resource "aws_route_table" "jenkins_rtb" {
  vpc_id = aws_vpc.jenkins_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.jenkins_nat.id
  }

  tags = {
    Terraform = "true"
    Environment = var.environment
  }
}

resource "aws_route_table_association" "jenkins_rta" {
  subnet_id = aws_subnet.jenkins_subnet.id
  route_table_id = aws_route_table.jenkins_rtb.id
}
