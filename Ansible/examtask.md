 <h4>Task-1 Install and configure Ansible on the control-node control.realmX.example.com as follows </h4>

  - Task 1.1: node1.lab.example.com is a member of the dev host group
  - Task 1.2: node2.lab.example.com is a member of the test host group
  - Task 1.3: node3.lab.example.com & node4.realmX.example.com are 
              member of the prod host group 
  - Task 1.4: node5.lab.example.com is a member of the balancers host group.
              prod group members be member of the webservers host group too
  - Task 1.5  create a configuration file called ansible.cfg as follows
              the host inventory file /home/admin/ansible/inventory is
              defined
  - Task 1.6  the location of roles used in playbooks is defined as
              /home/admin/ansible/roles       
    <h3>inventory file </h3>

         [dev]
         node1.lab.example.com
         [test]
         node2.lab.example.com
         [prod]
         node3.lab.example.com
         node4.lab.example.com
         [balancers]
         node5.lab.example.com
         [webserver:children]
         prod


    <h3>copy Ansible.cfg the ansible configuration from the /etc/ansible/ansible.cfg to respective path and perfom modification in the file</h3>

          inventory     =  /home/admin/ansible/inventory
          roles_path    =  /home/admin/ansible/role

 <h4>Task-2 Create and run an Ansible ad-hoc command</h4>

  - Task 2.1: As a system administrator, you will need to install software 
              on the managed nodes.
  - Task 2.2: Create a shell script called yum-pack.sh that runs an ansible
  - Task 2.3: ad-hoc command to create yum-repository on each of the
              managed nodes as follows

    <h3>BaseOS repo</h3>

         The name of the repository is EX407
         The description is Ex407 Description
         The base URL is http://content.example.com/rhel8.0/x86_64/dvd/BaseOS/
         GPG signature checking is enabled
         The GPG key URL is http://content.example.com/rhel8.0/x86_64/dvd/RPM-GPG-KEY-redhat-release
         The repository is enabled

    <h3>AppStream repo</h3>

         The name of the repository is EXX407
         The description is Exx407 Description
         The base URL is http://content.example.com/rhel8.0/x86_64/dvd/AppStream/
         GPG signature checking is enabled
         The GPG key URL is http://content.example.com/rhel8.0/x86_64/dvd/RPM-GPG-KEY-redhat-release 
         The repository is enabled

    ```bash

          #!/bin/bash
          ansible all -m yum_repository -a 'file=BaseOs name=EX407 description=Ex407 baseurl=http://content.example.com/rhel8.0/x86_64/dvd/BaseOS/ gpgcheck=yes gpgkey=http://content.example.com/rhel8.0/x86_64/dvd/RPM-GPG-KEY-redhat-release enabled=yes'
          ansible all -m yum_repository -a 'file=AppStream name=EXX407 description=Exx407 baseurl=http://content.example.com/rhel8.0/x86_64/dvd/AppStream/ gpgcheck=yes gpgkey=http://content.example.com/rhel8.0/x86_64/dvd/RPM-GPG- KEY-redhat-release enabled=yes'


 <h4>Task-3 Create a playbook called packages.yml that:</h4>

  - Task 3.1: As a system administrator, you will need to install software 
              on the managed nodes.
  - Task 3.2: Create a shell script called yum-pack.sh that runs an ansible
  - Task 3.3: ad-hoc command to create yum-repository on each of the
              managed nodes as follows


    ```yaml
    
        ---
        - name: install the package
          hosts: dev,test,prod 
          tasks:
            - name: install the package 
                yum:
                  name: "{{item}}"
                  state: latest
                loop:
                  - php
                  - mariadb
        - name: install the package in dev
          hosts: dev 
          tasks:
            - name: install the package 
                yum:
                  name: "@Development Tools"
                  state: latest
        - name: exclude kernel 
          hosts: dev
          tasks:
            - name: exculde the kernel 
                yum:
                  name: "*"
                  state: latest 
                  exclude: kernel

 <h4> Task-4 Install the RHEL system Role pacakage and create the playbook timesync.yml that </h4>

  - Task 4.1 run over all managed nodes
  - Task 4.2 use the timesync role
  - Task 4.3 Configure the role to use the time server classroom.example.com in exam 192.168.10.254
  
  <h4>install ansible system role</h4>

    sudo yum install rhel-system-roles.noarch -y
    point ansible.cfg role parameter to 
    /usr/share/ansible/roles/rhelsystem-roles.timesync

    
    ```yaml

        --- 
        - name: Timesync role playbook
          hosts: all 
          vars:   
            timesync_ntp_provider: chrony
            timesync_ntp_servers:
              - hostname: classroom.example.com
                iburst: yes
            timezone: Asia/Kolkata 
          roles:
            - rhel-system-roles.timesync 
          tasks:
            - name: set the timezone
              timezone: 
                name: "{{timezone}}"