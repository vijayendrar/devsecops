
#!/bin/bash
sudo apt-get update
sudo apt-get install -y curl
curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io.key 
curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo tee \
/usr/share/keyrings/jenkins-keyring.asc > /dev/null
echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc]" \
https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
/etc/apt/sources.list.d/jenkins.list > /dev/null
sudo apt install -y default-jre
sudo apt-get update
sudo apt-get  install -y jenkins
sudo sed -i 's/Environment="JENKINS_PORT=8080"/Environment="JENKINS_PORT=7000"/g' /lib/systemd/system/jenkins.service
sudo systemctl daemon-reload
sudo systemctl restart jenkins.service
sudo systemctl stop ufw