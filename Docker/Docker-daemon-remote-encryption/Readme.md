# Access Docker machine remotely with encryption and TLS mechanism #

note: Run command with necessary priveledges if not work in your environment

## Run these command on docker server to Create a CA, server and client keys with OpenSSL ##

```cmd

      openssl genrsa -aes256 -out ca-key.pem 4096  [enter passphrase]
      
      openssl req -new -x509 -days 365 -key ca-key.pem -sha256 -out ca.pem

      openssl genrsa -out server-key.pem 4096

      openssl req -subj "/CN=docker.example.dom" -sha256 -new -key server-key.pem -out server.csr

      echo subjectAltName = DNS:docker.example.dom,IP:192.168.0.246,IP:127.0.0.1 >> extfile.cnf [type youre ip address of docker server]

      echo extendedKeyUsage = serverAuth >> extfile.cnf

      openssl x509 -req -days 365 -sha256 -in server.csr -CA ca.pem -CAkey ca-key.pem  \
     -CAcreateserial -out server-cert.pem -extfile extfile.cnf

 ```

## create the client directory and run below mention command on the same server ##

```cmd

    openssl genrsa -out key.pem 4096

    openssl req -subj '/CN=client' -new -key key.pem -out client.csr

    echo extendedKeyUsage = clientAuth > extfile-client.cnf
    
    openssl x509 -req -days 365 -sha256 -in client.csr -CA ca.pem -CAkey ca-key.pem \
      -CAcreateserial -out cert.pem -extfile extfile-client.cnf [copy ca-key.pem ca.pem from previous folder]
```

## copy ca.pem.server-cert.pem,server-key.pem to  /etc/docker/ssl/ ##

- ca.pem
- server-cert.pem
- server-key.pem

## configure dameon.json file and restart docker the service ##

```json

{
    "tls": true,
    "tlsverify": true,
    "tlscacert": "/etc/docker/ssl/ca.pem",
    "tlscert": "/etc/docker/ssl/server-cert.pem",
    "tlskey": "/etc/docker/ssl/server-key.pem",   
    "insecure-registries":[
        "192.168.50.10:5000"
    ]
}

```

## copy below mention file to your client machine ##

- ca.pem
- cert.pem
- key.pem
- place all the key into .docker folder in client system
- install docker desktop for windows in your system

## configure the environment variable in windows system ##

- set DOCKER_HOST=tcp://192.168.50.10:2376 [change ip according to your environment]
- set DOCKER_TLS_VERIFY=1
