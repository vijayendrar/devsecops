#!/bin/bash
sudo apt-get update 
sudo apt-get  install -y curl
sudo apt install -y software-properties-common
sudo apt-get update && apt-get install -y gnupg2
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
sudo apt-get update && sudo apt-get install -y vault
sudo apt-get install -y vim 
sudo mkdir -p /vault/data 
sudo chown -R vault:vault /vault/data

## for certificate creation ##
sudo mkdir -p /cert/ca 
cd /cert/ca/ || exit
sudo openssl genrsa -out CA.key -des3 -passout pass:rock123
sudo openssl req -x509 -sha256 -new -nodes -days 3650 -key CA.key -out CA.pem -passin pass:rock123 \
-subj "/C=IN/ST=GJ/L=AH/O=Global Security/OU=IT Department/CN=vaultserver01.example.dom"

sudo mkdir -p /localhost
cd  /localhost || exit
cat << EOF > localhost.ext

authorityKeyIdentifier = keyid,issuer
basicConstraints = CA:FALSE
keyUsage = digitalSignature, nonRepudiation, keyEncipherment, dataEncipherment
subjectAltName = @alt_names

[alt_names]
DNS.1 = localhost
IP.1 = 127.0.0.1
DNS.2 = vaultserver01.example.dom
IP.2 = 192.168.50.10
EOF

## make change in /etc/host file #

cat << EOF > /etc/hosts
127.0.0.1 vaultserver01.example.dom
192.168.50.10 vaultserver01.example.com
EOF

sudo openssl genrsa -out localhost.key -des3  -passout  pass:rock123
sudo  openssl req -new -key localhost.key -out localhost.csr -passin pass:rock123 \
-subj "/C=IN/ST=GJ/L=AH/O=Global Security/OU=IT Department/CN=vaultserver01.example.dom"

cat << EOF > localhost.ext

authorityKeyIdentifier = keyid,issuer
basicConstraints = CA:FALSE
keyUsage = digitalSignature, nonRepudiation, keyEncipherment, dataEncipherment
subjectAltName = @alt_names

[alt_names]
DNS.1 = localhost
IP.1 = 127.0.0.1
DNS.2 = vaultserver01.example.dom
IP.2 = 192.168.50.10
EOF

sudo openssl x509 -req -in localhost.csr -CA /cert/ca/CA.pem -CAkey /cert/ca/CA.key -CAcreateserial -days 3650 -sha256 -extfile localhost.ext -out localhost.crt -passin pass:rock123
sudo cp localhost.crt localhost.key  /opt/vault/tls
sudo openssl rsa -in localhost.key -out localhost.decrypted.key -passin pass:rock123
sudo mv localhost.decrypted.key /opt/vault/tls/localhostd.key
sudo cp /cert/ca/CA.pem /opt/vault/tls
sudo chown -R vault:vault /opt/vault/tls/


cat << EOF > /etc/vault.d/vault.hcl 
ui = true

storage "raft" {
  path    = "/vault/data"  
}

listener "tcp" {
  address       = "0.0.0.0:8200"
  tls_cert_file = "/opt/vault/tls/localhost.crt"
  tls_key_file  = "/opt/vault/tls/localhostd.key"
}

api_addr = "https://192.168.50.10:8200"
cluster_addr = "https://127.0.0.1:8201"
EOF
sudo chown -R vault:vault /etc/vault.d/vault.hcl
sudo chmod -R 755 /opt/vault/tls
sudo systemctl enable --now vault.service
export VAULT_CACERT=/opt/vault/tls/CA.pem
export VAULT_ADDR='https://192.168.50.10:8200'
vault operator init
