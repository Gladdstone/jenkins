resource "aws_vpc" "jenkins_vpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "dedicated"

  tags = {
    Name = "jenkins"
  }
}

resource "aws_subnet" "jenkins_subnet" {
  vpc_id            = "${aws_vpc.jenkins_vpc.id}"
  cidr_block        = "172.16.10.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "jenkins"
  }
}

resource "aws_network_interface" "jenkins_interface" {
  subnet_id   = "${aws_subnet.jenkins_subnet.id}"

  tags = {
    Name = "jenkins"
  }
}