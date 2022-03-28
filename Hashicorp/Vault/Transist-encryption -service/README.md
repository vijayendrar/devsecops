# Transist secret engine #

## Transit Secret engine Architecuture ##

![image](https://github.com/vijayendrar/devsecops/blob/main/Hashicorp/Vault/image/Page-2.png)

## Transit engine configuration flow ##

![image](https://github.com/vijayendrar/devsecops/blob/main/Hashicorp/Vault/image/Page-3.png)

## install the vault on AWS Ubuntu Instance ##

```cmd

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

```

## create and Associcate ELastic iP to DNS name in Hosting console ##

![image](https://github.com/vijayendrar/devsecops/blob/main/Hashicorp/Vault/image/domain%20map.jpg)

map elastic ip address to your ubuntu instance

## generate and map the certificate in vault domain ##

:one:   install the certbot using sudo apt-get  install certbot

:two:   sudo certbot certonly --standalone -d vaultserver01.devsecopsproject.in

:three:  copy fullchain.pem and privkey.pem to  /etc/vault.d/

:four:   Chanage the ownership using sudo chown -R vault:vault /etc/vault.d/

:five:   give access right using  sudo chmod 755  /etc/vault.d/*.pem

## configure the vault.hcl file  and start vault service ##

```hcl

ui = true

storage "raft" {
  path    = "/vault/data"
}

listener "tcp" {
  address       = "172.31.89.157:8200"
  tls_cert_file = "/etc/vault.d/fullchain.pem"
  tls_key_file  = "/etc/vault.d/privkey.pem" 
}

api_addr = "https://172.31.89.157:8200"
cluster_addr = "https://127.0.0.1:8201

```

then run sudo systemctl enable --now vault.service

Access the vault ui using <https://vaultserver01.devsecopsproject.in:8200>

generate shamir secret and root key and unseal the vault

## create security engineer policy ##

![image](https://github.com/vijayendrar/devsecops/blob/main/Hashicorp/Vault/image/policy%20craation.jpg)

## enable transit secret engine name mu_app_key and create Policy for security Engineer ##

```hcl

# Manage the transit secrets engine
path "transit/keys/*" {
  capabilities = [ "create", "read", "update", "delete", "list", "sudo" ]
}

# Enable the transit secrets engine
path "sys/mounts/transit" {
  capabilities = [ "create", "update" ]
}

# Write ACL policies
path "sys/policies/acl/*" {
  capabilities = [ "create", "read", "update", "delete", "list" ]
}

# Create tokens for verification & test
path "auth/token/create" {
  capabilities = [ "create", "update", "sudo" ]
}

```

## attach policy to username/password auth ##

![image](https://github.com/vijayendrar/devsecops/blob/main/Hashicorp/Vault/image/username.jpg)

## login with username and password and copy security engineer token ##

![image](https://github.com/vijayendrar/devsecops/blob/main/Hashicorp/Vault/image/password.jpg)

## copy token for security engineer #

![image](https://github.com/vijayendrar/devsecops/blob/main/Hashicorp/Vault/image/tokencopy.jpg)

## login with security engineer from ui and create app policy ##

```hcl
path "transit/keys/my_app_key" {
  capabilities = ["read"]
}

path "transit/rewrap/my_app_key" {
  capabilities = ["update"]
}

path "transit/encrypt/my_app_key" {
  capabilities = ["update"]
}

```
## login security engineer token using cli and create app policy token ##

![image](https://github.com/vijayendrar/devsecops/blob/main/Hashicorp/Vault/image/token.jpg)

## perform step on application server in our case it is centos machine ##

step -1  git clone <https://github.com/hashicorp/vault-guides.git>

Step -2  install the docker on the centos version 8

```cmd

 yum-config-manager \
     --add-repo \
     <https://download.docker.com/linux/centos/docker-ce.repo>
```

Step -4  yum-config-manager --enable docker-ce-nightly

Step-5  yum install docker-ce docker-ce-cli containerd.io

Step-6  yum  install  dotnet-sdk-5.0

step-7 docker pull mysql/mysql-server:5.7

Step-8

```cmd

docker run --name mysql-rewrap \
        --publish 3306:3306 \
        --volume ~/rewrap-data:/var/lib/mysql \
        --env MYSQL_ROOT_PASSWORD=root \
        --env MYSQL_ROOT_HOST=% \
        --env MYSQL_DATABASE=my_app \
        --env MYSQL_USER=vault \
        --env MYSQL_PASSWORD=vaultpw \
        --detach mysql/mysql-server:5.7

```

step:9

```hcl

    VAULT_TOKEN=s.iZW56SyrmO7agdce8aXIIlpS \
    VAULT_ADDR=https://vaultserver01.devsecopsproject.in:8200 \
    VAULT_TRANSIT_KEY=my_app_key \
    SHOULD_SEED_USERS=true \
    dotnet run

```

step:10 final output

![image]