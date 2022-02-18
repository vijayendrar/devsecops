<h4>Task-1 Install and configure Ansible on the control-node control.realmX.example.com as follows </h4>

- Task 1.1: node1.lab.example.com is a member of the dev host group
- Task 1.2: node2.lab.example.com is a member of the test host group
- Task 1.3: node3.lab.example.com & node4.realmX.example.com are  member of the prod host group
- Task 1.4: node5.lab.example.com is a member of the balancers host group.prod group members be member of the webservers host group too
- Task 1.5:  create a configuration file called ansible.cfg as follows
              the host inventory file /home/admin/ansible/inventory is
              defined
- Task 1.6  the location of roles used in playbooks is defined as /home/admin/ansible/roles

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

    <h3>copy Ansible.cfg the ansible configuration from the /etc/ansible/ansible.cfg to respective path and perfom modification in the file</h4>

          inventory     =  /home/admin/ansible/inventory
          roles_path    =  /home/admin/ansible/role

 <h4>Task-2 Create and run an Ansible ad-hoc command</h4>

- Task 2.1: As a system administrator, you will need to install software on the managed nodes.
- Task 2.2: Create a shell script called yum-pack.sh that runs an ansible
- Task 2.3: ad-hoc command to create yum-repository on each of the  managed nodes as follows

    <h4>BaseOS repo</h4>

        The name of the repository is EX407
        The description is Ex407 Description
        The base URL is http://content.example.com/rhel8.0/x86_64/dvd/BaseOS/
        GPG signature checking is enabled
        The GPG key URL is http://content.example.com/rhel8.0/x86_64/dvd/RPM-GPG-KEY-redhat-release
        The repository is enabled

    <h4>AppStream repo</h4>

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

- Task 3.1: installs the php and mariadb packages on hosts in the dev, test, and prod host groups.
- Task 3.2: installs the Development Tools package group on hosts in the dev host group.
- Task 3.3: updates all packages to the latest version on hosts in the dev host group

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

<h4>Task-4 Install the RHEL system Role pacakage and create the playbook timesync.yml that</h4>

- Task 4.1 run over all managed nodes
- Task 4.2 use the timesync role
- Task 4.3 Configure the role to use the time  server classroom.example.com in exam 192.168.10.254
  
    <h4>install ansible system role</h4>

    <!-- tsk -->
        sudo yum install rhel-system-roles.noarch -y
        point ansible.cfg role parameter to 
        /usr/share/ansible/roles/rhelsystem-roles.timesync

    <!-- tsk -->

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

<h4> Task-5 Create a role called apache in /home/admin/ansible/roles with the following requirements:</h4>

- Task 5.1  The httpd package is installed, enabled on boot, and started.
- Task 5.2  the firewall is enabled and running with a rule to allow access to the web server
- Task 5.3 template file index.j2 is used to create the file ‘/var/www/html/index.html’ with the output :
             Welcome to HOSTNAME on IPADDRESS
  
    Where HOSTNAME is the fqdn of the managed node and IPADDRESS is the IP-Address of the managed node. Create a playbook called httpd.yml that uses this role and the playbook runs on hosts in the webservers host group

    <h5>  step-1 create the directory for the role</h5>

        mkdir -p  /home/admin/ansible/roles

    <h5> step-2 initiliaze the apache role skeleton </h5>

        ansible-galaxy init apache

    <h5> step-3 it will create the below structure </h5>

    ![image](https://github.com/vijayendrar/devsecops/blob/main/Ansible/images/skel.png)

    <h5> create the file under apache/tasks/main.yml </h5>

        - include_tasks: install.yml 
        - include_tasks: service.yml
        - include_tasks: firewall.yml
        - include_tasks: webpage.yml

    <h5>Define the variable vim apache/vars/main.yml </h5>

        pkg: httpd
        srv: httpd
        fw: http
        webpage: /var/www/html/index.html
        template: index.j2

    <h5>Create the install yaml file vim apache/tasks/install.yml</h5>
    <!-- tsk -->
    
    ```yaml
        ---
        - name: install {{pkg}}
          yum:
            name: "{{pkg}}" 
            state: latest
    ```         
    <h5>Create the service file vim apache/tasks/service.yml</h5>

    <!-- tsk -->
    ```yaml
        ---
        - name: enable/start {{srv}}
          service:
            name: "{{srv}}" 
            enabled: true 
            state: started
    ``` 
    <h5> Enable the firewall and add the rules vim apache/tasks/firewall.yml</h5>

    <!-- tsk -->
    ```yaml
        ---
        - name : open {{fw}} on firewalld
          firewalld:
            service: "{{fw}}"
            state: enabled
            immediate: yes
            permanent: true 
    ```

    <h5>Create the webpage template : vim apache/tasks/webpage.yml</h5>

    <!-- tsk -->
    ```yaml
            - name: create {{webpage}}
              template:
                src: "{{template}}"
                dest: "{{webpage}}"
                notify: restart_httpd
    ```
    <h5>Restart the http service vim apache/handlers/main.yml</h5>

    <!-- tsk -->
    ```yaml
            - name: restart_httpd
              service:
                name: "{{http_srv}}" 
                state: restarted
    ```
    <h5> create the jinja2 file </h5>

        Welcome to {{ansible_fqdn}} on {{ansible_default_ipv4.address}}

    <h5>Create the httpd.yml file : vim httpd.yml</h5>

    <!-- tsk -->
    ```yaml
        ---
        - name:
          hosts: webservers 
          roles:
            - apache
    ```
<h4>Task-6 Create a playbook called web.yml as follows:</h4>

- Task 5.1 The playbook runs on managed nodes in the dev host group. Create the directory /webdev with the following requirements
- Task 5.2 membership in the apache group
- Task 5.3 regular permissions: owner=r+w   +execute, group=r+w+execute, other=r+execute s.p=set group-id -symbolically link /webdev to /var/www/html/webdev
- Task 5.4 create the file /webdev/index.html with single-line of text the reads: Development
- Task 5.5 it should be available on http://servera.lab.example.com/webdev/index.html 

    <!-- tsk -->
    ```yaml
    
        - name : install the webserver 
          hosts: dev
          tasks:

            - name: Start service httpd service
              service:
              name: httpd
              enabled: true
              state: started

            - name: enable firewall and add http rule
                firewalld:
                    service: http
                    permanent: yes
                    state: enabled

            - name: directory for the symbolik link
                file:
                    path: /webdev
                    state: directory
                    group: apache
                    mode: "2775"
                    setype: httpd_sys_content_t

            - name: Touch a file and create file
                file:
                    path: /webdev/index.html
                    state: touch
                    setype: httpd_sys_content_t

            - name: configure the directory with ownserhship
                file:
                    path: /var/www/html/webdev
                    state: directory
                    mode: '2775'
                    group: apache

            - name: Add file with line
                lineinfile:
                    path: /webdev/index.html
                    line: Development
                    create: yes
                    state: present

            - name: Create a symbolic link
                file:
                    src: /webdev/
                    dest: /var/www/html/webdev
                    state: link
                    force: yes

        - name: service http restarted
          service:
            name: httpd
            state: restarted
    ```          
<h4>Task-7 Create an Ansible vault to store user passwords as follows: The name of the vault is vault.yml The vault contains two variables as follows:</h4>

- Task-7.1 dev_pass with value wakennym
- Task 7.2 mgr_pass with value rocky
- Task 7.3 The password to encrypt and decrypt the vault is atenorth
- Task 7.4 The password is stored in the file /home/admin/ansible/password.txt


        Create passsword.txt with text atenorth 
        Ansible-vault create valult.yml   --vault-password-file=password.txt

    <!-- tsk -->
         Then write below mention text in open file 
          ---
          - dev_pass: wakennym
          - mgr_pass: rocky
         
<h4> Task-8 Generate a hosts file</h4>

- Task 8.1 Download an initial template file hosts.j2 from http://classroom.example.com/hosts.j2 to /home/admin/ansible/ Complete the template so that it can be used to generate a file with a line for each inventory host in the same format as /etc/myhosts 
  
        example: 172.25.250.9 workstation.lab.example.com workstation

- Task 8.2 Create a playbook called gen_hosts.yml that uses this template to generate the file /etc/myhosts on hosts in the dev host group. When completed, the file /etc/hosts on hosts in the dev host group should have a line for each managed host:

        127.0.0.1 localhost localhost.localdomain localhost4 localhost4.localdomain4
        ::1 localhost localhost.localdomain localhost6 localhost6.localdomain6
        172.25.250.10 serevra.lab.example.com servera

    <!-- tsk -->
    <h4>downloaded host.j2 file </h4>

        127.0.0.1  localhost
        {{ansible_default_ipv4.address}} {{ansible_fqdn}} {{ansible_hostname}}

    <h4>gen_hosts.yml file</h4>
    
    ```yaml 
        - name : template to generate the host file
          hosts: dev
          tasks:

        - name: Template for the host file
          template:
            src: /template/hosts.j2
            dest: /etc/myhosts
    ```
<h4> Task-9 Create a playbook called hwreport.yml that produces an output file called /root/hwreport.txt on all managed nodes with the following information:</h4>

- Task 9.1  Inventory host name 
- Task 9.2  Total memory in MB -BIOS version
- Task 9.3  Size of disk device vda
- Task 9.4  Size of disk device vdb
- Task 9.5  Each line of the output file contains a single key-value pair. 
- Task 9.6 Your playbook should:
Download the file ‘hwreport.empty’ from the URL ‘http://classroom.example.com/hwreport.empty’ and save it as ‘/root/hwreport.txt’ Modify with the correct values.
NOTE: If a hardware item does not exist, the associated value should be set to NONE


    ```yaml
        - name: create the hardware report
          hosts: all
          tasks:

        - name: Download foo.conf
            get_url:
                url: http://content.example.com/rhexam/rh294/materials/hwreport.empty
                dest: /root/hwreport.txt

        - name: replace the file paramete
            replace:
                path: /root/hwreport.txt
                regexp: "{{ item.src }}"
                replace: "{{ item.dest }}"

            loop:
              - src: INVENTORY_HOSTNAME
                dest : "{{ ansible_hostname }}"
              - src: BIOS_VERSION
                dest : "{{ ansible_bios_version }}"
              - src: TOTAL_MEMORY
                dest : "{{ ansible_memtotal_mb}}"
              - src: SDA_SIZE
                dest : "{{ ansible_devices.sda.size }}"
              - src: SDB_SIZE
                dest:  "{{ ansible_devices.sda.size }}"
    ```            
<h4> Task-10 Modify file content </h4>

- Task 10.1 Create a playbook called ‘/home/admin/ansible/modify.yml’ as follows:
- Task 10.2 The playbook runs on all inventory hosts
- Task 10.3 The playbook replaces the contents of ‘/etc/issue’ with a single line of text as follows:
- Task 10.4 On hosts in the dev host group, the line reads: “Development”
- Task 10.5 On hosts in the test host group, the line reads: “Test”
-Task 10.6 On hosts in the prod host group, the line reads: “Production”

    ```yaml

      - name: copy content and modify it
        hosts: all
        tasks:

      - name: Copy file to dev group
        copy:
          dest: /etc/issue
          content: "Development"
        when: inventory_hostname in groups ["dev"]

      - name: Copy file to test group
        copy:
          dest: /etc/issue
          content: "test"
        when: inventory_hostname in groups ["test"]

      - name: Copy file with owner and production group
        copy:
          dest: /etc/issue
          content: "production"
        when: inventory_hostname in groups ["production"]
    ```    










