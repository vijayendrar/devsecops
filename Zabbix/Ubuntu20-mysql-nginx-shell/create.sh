#!/bin/bash
sudo apt-get update
sudo apt-get install -y vim 
wget https://repo.zabbix.com/zabbix/6.0/ubuntu/pool/main/z/zabbix-release/zabbix-release_6.0-1+ubuntu20.04_all.deb
sudo dpkg -i zabbix-release_6.0-1+ubuntu20.04_all.deb
sudo apt update
sudo apt install -y zabbix-server-mysql zabbix-frontend-php zabbix-nginx-conf zabbix-sql-scripts zabbix-agent
sudo apt install -y mysql-server
sudo sh -c 'echo  "[mysql]\nuser=root\npassword=" >> /etc/mysql/my.cnf'
sudo sh -c "cat << EOF >> /tmp/mysql.sql
create database zabbix character set utf8mb4 collate utf8mb4_bin;
CREATE USER 'zabbix'@'localhost' IDENTIFIED BY 'zabbix';
grant all privileges on zabbix.* to zabbix@localhost;
\q
EOF"
sudo sh -c "mysql -u root < /tmp/mysql.sql"
sudo zcat /usr/share/doc/zabbix-sql-scripts/mysql/server.sql.gz | sudo mysql -h localhost -uzabbix -pzabbix zabbix
sudo sed -i 's/# DBPassword=/DBPassword=zabbix/g' /etc/zabbix/zabbix_server.conf
sudo sed -i 's/# listen          80;/listen          80;/g' /etc/zabbix/nginx.conf
sudo sed -i 's/# server_name    example.com;/server_name    192.168.50.50;/g' /etc/zabbix/nginx.conf
sudo systemctl restart zabbix-server zabbix-agent nginx php7.4-fpm
sudo systemctl enable zabbix-server zabbix-agent nginx php7.4-fpm

