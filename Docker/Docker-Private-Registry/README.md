# configure the docker private registry #
  
1.Create registry service and run on the  manger node

---

docker service create --name registry --publish published=5000,target=5000 --constraint node.role==manager registry:2

---

2.Verify the service running on manager node docker service ps registry

![image](https://github.com/vijayendrar/devsecops/blob/main/Docker/Images/service%20status.jpg)

3.Create the  file at etc/docker/daemon.json do these on all nodes including manager node service deploy on manager node

```json

{
    "insecure-registries":[
        "192.168.50.10:5000"
    ]
}

```

4.Create the custom image with the tag docker build -t 192.168.50.10:5000/my-nginx .

```Dockerfile

FROM nginx:latest
RUN apt update && apt install -y net-tools
RUN chmod +r /usr/share/nginx/html/index.html
CMD ["nginx", "-g", "daemon off;"]

```

5.Now push the image to local registry docker push 192.168.50.10:5000/my-nginx

![image]()

