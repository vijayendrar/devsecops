# deploy Wordpress and Mysql service in Swarm Mode using docker stack and Compose file #

## Docker Swarm Architecture with service deployment ##

![image](https://github.com/vijayendrar/devsecops/blob/main/Docker/Images/docker%20stack.png)

## software requirements ##

- configure your virtualbox to host networking

![image](<https://github.com/vijayendrar/devsecops/blob/main/Docker/Images/Host%20Networking.jpg>)

- download and install the vagragnt and virtual box
- install the vagrant plugin install vagrant-vbguest

## copy docker-stack.yml file to manager node along with all .env file ##

- execute docker stack deploy -c docker-stack.yml  mystack
- it will create the relevant services in appropriate node

## test configuration using beleow mention url ##

- <http://192.168.50.101>
- <http://192.168.50.102:81>
  