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
