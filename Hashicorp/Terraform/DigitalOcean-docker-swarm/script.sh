#!/bin/sh
sudo apt-get update 
sudo apt-get install \
    ca-certificates \
    curl \
    gnupg \
    lsb-release 

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update
sudo apt-get -y install docker-ce docker-ce-cli containerd.io 
sudo systemctl enable docker.service 
sudo systemctl start docker.service

# configure firewall for docker ports #
yes | ufw enable

ufw allow 22/tcp
ufw allow 2376/tcp
ufw allow 2377/tcp
ufw allow 7946/tcp
ufw allow 7946/udp
ufw allow 4789/udp
ufw allow 8080/tcp

ufw reload 

# get the private ip address #

private_ip=$(hostname -I | cut -d " " -f 3)

# start the swarm #
docker swarm init \
--listen-addr $private_ip \
--advertise-addr $private_ip



