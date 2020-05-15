# network
output "jenkins_subnet" {
    value       = aws_subnet.jenkins_subnet.id
    description = "Jenkins VPC private subnet list"
}

output "jenkins_vpc_id" {
    value      = aws_vpc.jenkins_vpc.id
}

output "jenkins_sg_id" {
    value       = aws_security_group.jenkins_sg.id
    description = "ID of Jenkins security group"
}