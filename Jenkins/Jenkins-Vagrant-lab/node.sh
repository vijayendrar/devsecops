#!/bin/bash
sudo apt-get update
sudo apt-get install -y curl
sudo apt install -y default-jre
sudo apt-get update
sudo systemctl stop ufw
sudo useradd -m jenkins -s /bin/bash
sudo -u jenkins ssh-keygen -t rsa  -f /home/jenkins/.ssh/id_rsa -q -P ""
sudo -u jenkins cat /home/jenkins/.ssh/id_rsa.pub | sudo  tee -a /home/jenkins/.ssh/authorized_keys