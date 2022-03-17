# Docker Swarm Create with one manager and 3 Worker node #

- vagrantfile
- manager.sh
- worker.sh
- install **vagrant plugin install vagrant-vbguest**.
it will install virtual box guest additons

## port forwarding configured under vagrant manager node ##

- port 3000:80
- inside docker container custom container build using dockerfile

```dockerifile

                FROM nginx:latest
                COPY ./index.html /usr/share/nginx/html/index.html
                RUN chmod +r /usr/share/nginx/html/index.html
                CMD ["nginx", "-g", "daemon off;"]

```

- docker run -d --name mynginx -p 3000:80 custom-nginx
- check the firewall to allow specific port
- access the page from your machine 192.168.50.10:3000
