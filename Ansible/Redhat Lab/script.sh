#!/bin/bash
rm -rf /home/ansible/.ssh/*
echo "ansible ALL=NOPASSWD: ALL" > /etc/sudoers.d/ansible
sudo -u ansible ssh-keygen -t rsa  -f /home/ansible/.ssh/id_rsa -q -P ""
cat << EOF > /etc/hosts
192.168.50.101 node1
192.168.50.102 node2
192.168.50.103 node3
192.168.50.104 node4
192.168.50.105 node5
192.168.50.20  content.example.com 
EOF
echo "root123" > password.txt
sudo -u ansible sshpass -f /vagrant/password.txt \
sudo -u ansible ssh-copy-id -f -i /home/ansible/.ssh/id_rsa.pub -o StrictHostKeyChecking=no  ansible@node1

sudo -u ansible sshpass -f /vagrant/password.txt \
sudo -u ansible ssh-copy-id -f -i /home/ansible/.ssh/id_rsa.pub -o StrictHostKeyChecking=no  ansible@node2