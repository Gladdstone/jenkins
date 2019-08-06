# Jenkins does not currently support Java 10 or later
yum install -y java-1.8.0-openjdk-devel
# Install Jenkins
wget -O /tmp/jenkins.repo http://pkg.jenkins-ci.org/redhat/jenkins.repo
rpm --import https://jenkins-ci.org/redhat/jenkins-ci.org.key
mv /tmp/jenkins.repo /etc/yum.repos.d
yum install -y jenkins
# Start Jenkins service
systemctl start jenkins.service
# Enable start on boot
systemctl enable jenkins
# Enable port 8080
firewall-cmd --zone=public --add-port=8080/tcp --permanent
firewall-cmd --reload
