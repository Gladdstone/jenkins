# Install and enable firewall management daemon
yum install -y firewalld
systemctl start firewalld
systemctl enable firewalld
# Enable port 8080
firewall-cmd --zone=public --add-port=8080/tcp --permanent
firewall-cmd --reload
# Jenkins does not currently support Java 10 or later
yum install -y java-1.8.0-openjdk-devel
# Install Jenkins
wget -O /tmp/jenkins.repo http://pkg.jenkins-ci.org/redhat/jenkins.repo
rpm --import https://jenkins-ci.org/redhat/jenkins-ci.org.key
yum install -y jenkins
# Start Jenkins service
systemctl start jenkins
# Enable start on boot
systemctl enable jenkins
