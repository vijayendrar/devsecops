# configure the docker private registry #
  
1.Create registry service and run on the  manger node

---

docker service create --name registry --publish published=5000,target=5000 --constraint node.role==manager registry:2

---

2.Verify the service running on manager node docker service ps registry

![image]()
