output "jenkins_interface_id" {
    value       = "${aws_network_interface.jenkins_interface.id}"
    description = "ID of the Jenkins subnet interface"
}