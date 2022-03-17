# Automate Redhat 8.5 Lab for Ansible Training #

## System Requirements ##
  
- operating system : windows 10
- Required Memory : 8 GB
- Harddrive space : 100 GB
- Each Virtual machine use Memory : 512 MB
- username: ansible
- password: root123
  
## system Architecture flow ##

![image](https://github.com/vijayendrar/devsecops/blob/main/Ansible/images/ansible%20lab.png)  

## change the vagrantfile paramter to adjust node count ##

- note : change the node count from 2 to 5 to increse the node in Lab

![image](https://github.com/vijayendrar/devsecops/blob/main/Ansible/images/nodecount.png)

## access machine after deployment ##

- vagrant ssh controller  <<= to access the controller these command need to execute from project folder
- vagrant ssh node1  <<= to access the node1
- vagrant ssh node2  <<= to access the node2 and so on

## setup ansible.cfg/inventory and repo ##

- login into controller using vagrant ssh controller
- su - ansible  then enter passsword root123
- create directory and configure ansible.cfg and inventory file
  
## ansible.cfg ##

    [defaults]
    inventory=/lab/inventory
    remote_user = ansible

    [privilege_escalation]
    become = true

## inventory ##

    [all]
    node1
    node2

## verify the configuration ##

ansible all -m ping

## use below mention command to configure ansible repo ##

## create adhoc.sh paste code and make executable using chmod +x adhoc.sh ##

``` bash

        #!/bin/bash
        ansible all -m  yum_repository -a  'name="RHEL8_BASEOS" description=" BaseOS Repo for RHEL 8"  baseurl="http://content.example.com/rhel8.0/x86_64/dvd/BaseOS" enabled=yes gpgcheck=no'

        ansible all -m  yum_repository -a  'name="RHEL8_APPSTREAM" description="AppStream Repo for RHEL 8"  baseurl=" http://content.example.com/rhel8.0/x86_64/dvd/AppStream" enabled=yes gpgcheck=no

```
