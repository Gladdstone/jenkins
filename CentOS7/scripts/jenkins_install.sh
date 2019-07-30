# Enable port 8080
firewall-cmd --permanent --zone=public --add-port=8080/tcp
firewall-cmd --reload
# Jenkins does not currently support Java 10 or later
yum install java-1.8.0-openjdk-devel
# Install Jenkins
curl --silent --location http://pkg.jenkins-ci.org/redhat-stable/jenkins.repo | sudo tee /etc/yum.repos.d/jenkins.repo
rpm --import https://jenkins-ci.org/redhat/jenkins-ci.org.key
yum install jenkins
# Start Jenkins service
systemctl start jenkins
# Enable start on boot
systemctl enable jenkins
