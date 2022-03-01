<h3>Automate Redhat 8.5 Lab for Ansible Training</h3> 

<h1>System Requirements </h1>
  
- operating system : windows 10
- Required Memory : 8 GB
- Harddrive space : 100 GB
- Each Virtual machine use Memory : 512 MB
- username: ansible
- password: root123
  

<h3> system Architecture flow </h3>

![image](https://github.com/vijayendrar/devsecops/blob/main/Ansible/images/ansible%20lab.png)  

<h3> change the vagrantfile paramter to adjust node count  </h3>

- note : change the node count from 2 to 5 to increse the node in Lab

![image](https://github.com/vijayendrar/devsecops/blob/main/Ansible/images/nodecount.png)

<h3> access machine after deployment  <h4>

- vagrant ssh controller  <<= to access the controller these command need to execute from project folder
- vagrant ssh node1  <<= to access the node1 
- vagrant ssh node2  <<= to access the node2 and so on 

<h3> setup ansible.cfg/inventory and repo </h3>

- login into controller using vagrant ssh controller
- su - ansible  then enter passsword root123
- create directory and configure ansible.cfg and inventory file
  
<h3> ansible.cfg </h3>
---
    [defaults]
    inventory=/lab/inventory
    remote_user = ansible

    [privilege_escalation]
    become = true
---    

<h3> inventory </h3>
---
    [all]
    node1
    node2
---

<h3> verify the configuration </h3>

ansible all -m ping

<h3> use below mention command to configure ansible repo </h3>

<h4> create adhoc.sh paste code and make executable using chmod +x adhoc.sh</h4>

 ```bash

    #!/bin/bash
    ansible all -m  yum_repository -a  'name="RHEL8_BASEOS" description=" BaseOS Repo for RHEL 8"  baseurl="http://content.example.com/rhel8.0/x86_64/dvd/BaseOS" enabled=yes gpgcheck=no'

    ansible all -m  yum_repository -a  'name="RHEL8_APPSTREAM" description="AppStream Repo for RHEL 8"  baseurl=" http://content.example.com/rhel8.0/x86_64/dvd/AppStream" enabled=yes gpgcheck=no



