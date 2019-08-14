# network
output "jenkins_private_subnets" {
    value       = "${module.jenkins_vpc.private_subnets}"
    description = "Jenkins VPC private subnet list"
}

output "jenkins_vpc_id" {
    value      = "${module.jenkins_vpc.vpc_id}"
}

output "jenkins_sg_id" {
    value       = "${module.jenkins_sg.this_security_group_id}"
    description = "ID of Jenkins security group"
}