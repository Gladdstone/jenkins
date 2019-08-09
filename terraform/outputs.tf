output "jenkins_private_subnets" {
    value       = "${module.jenkins_vpc.private_subnets}"
    description = "Jenkins VPC private subnet list"
}

output "jenkins_sg" {
    value       = "${aws_security_group.jenkins_sg}"
    description = "ID of Jenkins security group"
}