<h3>GOSSIP Encryption configuration Procedure in the Consul Server</h3> 

<h4>Step-1 Configure below mention paramter in  both server </h4> 
 
    "encrypt": "YlBnnO3y6gd5PKnBEmtTtzL9lobj3yeW8N060wrVvt0=",
    "encrypt_verify_incoming": false,
    "encrypt_verify_outgoing": false  

<h4>Step-2 configure the consul-client-01 and consul-client-02 </h4>
  
    "encrypt": "YlBnnO3y6gd5PKnBEmtTtzL9lobj3yeW8N060wrVvt0=",
    "encrypt_verify_incoming": false, 
    "encrypt_verify_outgoing": false
  
<h4>step-3 restart the consul service one by one in server and client</h4>
  
    systemctl restart consul   
  
<h4>step-4 change ** 'encrypt_verify_outgoing : true' ** then restart the consul service in client and server machine </h4> 
  
    "encrypt": "YlBnnO3y6gd5PKnBEmtTtzL9lobj3yeW8N060wrVvt0=",
    "encrypt_verify_incoming": false, 
    "encrypt_verify_outgoing": true
  
<h4>step-5 Restart the consul service in client as well as server</h4> 
  
    systemctl restart consul
  
<h4>step-6 Again restart the service after configuring below mention parameter</h4>
 
     "encrypt": "YlBnnO3y6gd5PKnBEmtTtzL9lobj3yeW8N060wrVvt0=",
     "encrypt_verify_incoming": true, 
     "encrypt_verify_outgoing": true
 
<h4>step-7  Restart the consul service in client and server</h4> 
 
    systemctl restart consul
