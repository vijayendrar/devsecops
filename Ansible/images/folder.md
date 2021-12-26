<h4> copy ansible.cfg to your project folder </h4>

    [Defaults]
    inventory= /package/inventory 


<h4> Create the inventory file in the same directory </h4>

        [dev]
        node1.lab.example.com

        [test]
        node2.lab.example.com

        [prod]
        node3.lab.example.com
        node4.lab.example.com

        [balancers]
        node5.lab.example.com

        [webserver]
        node3.lab.example.com
        node4.lab.example.com

<h4> list all the hosts </h4>

        ansible all --list-hosts

<h4> list all the node under the webserver group </h4>

        ansible webserver --list-hosts
