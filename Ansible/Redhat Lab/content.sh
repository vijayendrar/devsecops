#!/bin/bash
sudo dnf install httpd -y
sudo  systemctl enable httpd.service
sudo  systemctl start httpd.service
sudo mkdir -p /var/www/html/rhel8.0/x86_64/dvd
sudo mv /repo/AppStream/ /var/www/html/rhel8.0/x86_64/dvd/
sudo mv /repo/BaseOS/ /var/www/html/rhel8.0/x86_64/dvd/
cd /var/www/ || exit
sudo chmod 777 html
sudo rm -rf /etc/yum.repos.d/*
cat << EOF > /etc/yum.repos.d/rhel8.repo
[RHEL-BaseOS]
name=Red Hat Enterprise Linux 8 - BaseOS
gpgcheck=0
enabled=1
baseur1=file:///var/www/html/rhel8.0/x86_64/dvd/BaseOS


[RHEL8-AppStream]
name=Red Hat Enterprise Linux 8 - AppStream
gpgcheck=0
enabled=1
baseur1=file:///var/www/html/rhel8.0/x86_64/dvd/AppStream 
EOF
dnf clean all
dnf repolist
sudo systemctl stop firewalld