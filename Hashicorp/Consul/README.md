<h3>GOSSIP Encryption configuration Procedure in the Consul Server</h3> 

<h1>Step-1 Configure below mention paramter in  both server </h1> 
  ---
    "encrypt": "YlBnnO3y6gd5PKnBEmtTtzL9lobj3yeW8N060wrVvt0=",
    "encrypt_verify_incoming": false,
    "encrypt_verify_outgoing": false
  ---

<h1>Step-2 configure the consul-client-01 and consul-client-02 </h1>
  ---
    "encrypt": "YlBnnO3y6gd5PKnBEmtTtzL9lobj3yeW8N060wrVvt0=",
    "encrypt_verify_incoming": false, 
    "encrypt_verify_outgoing": false
  --- 



<h1>step-3 restart the consul service one by one in server and client</h1>
  ---
   systemctl restart consul
  ---

<h1>step-4 change ** 'encrypt_verify_outgoing : true' ** then restart the consul service in client and server machine </h1> 
  ---
   "encrypt": "YlBnnO3y6gd5PKnBEmtTtzL9lobj3yeW8N060wrVvt0=",
   "encrypt_verify_incoming": false, 
   "encrypt_verify_outgoing": true
  ---

<h1>step-5 Restart the consul service in client as well as server</h1> 
  ---
   systemctl restart consul
  ---

<h1>step-6 Again restart the service after configuring below mention parameter</h1>
  
 ---
 "encrypt": "YlBnnO3y6gd5PKnBEmtTtzL9lobj3yeW8N060wrVvt0=",
 "encrypt_verify_incoming": true, 
 "encrypt_verify_outgoing": true
 ---

<h1>step-7  Restart the consul service in client and server</h1> 
 
 ---
   systemctl restart consul
 ---



![image]()
