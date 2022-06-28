#!/bin/bash
sudo apt-get update
sudo apt-add-repository ppa:ansible/ansible -y
sudo apt install ansible -y
sudo useradd ansible -m --shell=/bin/bash
sudo -u  ansible mkdir /home/ansible/.ssh
sudo sh -c "cat << EOF > /etc/sudoers.d/ansible
ansible ALL=(ALL) NOPASSWD:ALL
EOF"