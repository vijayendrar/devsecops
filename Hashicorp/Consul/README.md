# GOSSIP Encryption configuration Procedure in the Consul Server #

## Step-1 Configure below mention paramter in  both server ##

    "encrypt": "YlBnnO3y6gd5PKnBEmtTtzL9lobj3yeW8N060wrVvt0=",
    "encrypt_verify_incoming": false,
    "encrypt_verify_outgoing": false  

## Step-2 configure the consul-client-01 and consul-client-02 ##
  
    "encrypt": "YlBnnO3y6gd5PKnBEmtTtzL9lobj3yeW8N060wrVvt0=",
    "encrypt_verify_incoming": false, 
    "encrypt_verify_outgoing": false
  
## step-3 restart the consul service one by one in server and client ##
  
    systemctl restart consul   
  
## step-4 change encrypt_verify_outgoing : true then restart the consul service in client and server machine ##
  
    "encrypt": "YlBnnO3y6gd5PKnBEmtTtzL9lobj3yeW8N060wrVvt0=",
    "encrypt_verify_incoming": false, 
    "encrypt_verify_outgoing": true
  
## step-5 Restart the consul service in client as well as server ##
  
    systemctl restart consul
  
## step-6 Again restart the service after configuring below mention parameter ##

     "encrypt": "YlBnnO3y6gd5PKnBEmtTtzL9lobj3yeW8N060wrVvt0=",
     "encrypt_verify_incoming": true, 
     "encrypt_verify_outgoing": true

## step-7  Restart the consul service in client and server ##

    systemctl restart consul

## consul-server-01 configuration ##

![image](https://github.com/vijayendrar/devsecops/blob/main/Hashicorp/Consul/gossip/consul-server-01.png)

## consul-server-02 configuration ##

![image](https://github.com/vijayendrar/devsecops/blob/main/Hashicorp/Consul/gossip/consul-server-02.png)

## consul-client-01 configuration ##

![image](https://github.com/vijayendrar/devsecops/blob/main/Hashicorp/Consul/gossip/consul-client-01.png)

## consul-client-02 configuration ##

![image](https://github.com/vijayendrar/devsecops/blob/main/Hashicorp/Consul/gossip/consul-client-02.png)

## consul key-ring list ##

![image](https://github.com/vijayendrar/devsecops/blob/main/Hashicorp/Consul/gossip/consul%20keyring.png)

## rotate the encryption key ##

![image](https://github.com/vijayendrar/devsecops/blob/main/Hashicorp/Consul/gossip/rotate.png)

## Rotate and install the new key ##

![image](https://github.com/vijayendrar/devsecops/blob/main/Hashicorp/Consul/gossip/new%20kwy.png)

## remove the old key to list the new keys ##

![image](https://github.com/vijayendrar/devsecops/blob/main/Hashicorp/Consul/gossip/remove%20the%20keys.png)

## after the installation restart the consul service in each node ##
