# HAproxy Configuration in docker swarm #

## HA proxy Architecture in Docker swarm ##

![image](https://github.com/vijayendrar/devsecops/blob/main/Docker/Images/HA.jpg)

## copy all the file to folder and run vagrant up ##

- manager,worker1,worker2 and HAproxy node will be created

- verify your swarm status by docker node ls

- run docker stack deploy --compose-file docker-compose.yml mystack to deploy service

- configure HA proxy server

---
            frontend myfrontend
            bind :80
            default_backend webservers

            backend webservers
            balance roundrobin
            mode http
            server s1 web1:3000 check
            server s2 web2:3001 check
            server s3 web3:3002 check
---  

- make sure chanage /etc/hosts file in haproxy accoding to these

---

    192.168.50.10   web1
    192.168.50.101  web2
    192.168.50.102  web3

---

[docker private registry configuration](https://github.com/vijayendrar/devsecops/tree/main/Docker/Docker-Private-Registry)
