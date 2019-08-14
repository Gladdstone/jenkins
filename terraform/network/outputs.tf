# network
output "jenkins_private_subnets" {
    value       = "${module.jenkins_vpc.private_subnets}"
    description = "Jenkins VPC private subnet list"
}

output "jenkins_vpc_id" {
    value      = "${module.jenkins_vpc.vpc_id}"
}