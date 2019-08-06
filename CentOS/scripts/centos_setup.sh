yum install -y wget
# Install and enable firewall management daemon
yum install -y firewalld
systemctl start firewalld
systemctl enable firewalld