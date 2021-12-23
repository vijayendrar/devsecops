<h3> GOSSIP Encryption configuration Procedure in the Consul Server </h3> 

Step-1 Configure below mention paramter in  both server 


"encrypt": "YlBnnO3y6gd5PKnBEmtTtzL9lobj3yeW8N060wrVvt0=",
"encrypt_verify_incoming": false,
"encrypt_verify_outgoing": false

Step-2 configure the consul-client-01 and consul-client-02 



step-3 restart the consul service one by one in server and client




step-4 change encrypt_verify_outgoing : true then restart the consul service in client and server machine 




step-5 Restart the consul service in client as well as server 



step-6 Again restart the service after configuring below mention parameter





step-7  Restart the consul service in client and server 



![image](https://user-images.githubusercontent.com/47826916/128641182-ebd21ce0-10b9-437f-891b-7a576cf70932.png)
