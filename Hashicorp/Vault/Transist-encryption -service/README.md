# Transist secret engine #

## Transit Secret engine Architecuture ##

![image](https://github.com/vijayendrar/devsecops/blob/main/Hashicorp/Vault/image/Page-2.png)

## Trnsit engine configuration flow ##

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




## configure your vault environment #

step-1  vault secrets enable transit

step-2  vault write -f transit/keys/my_app_key

step-3  create the policy

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

step-4 vault policy write rewrap_example ./rewrap_example.hcl

step-5 vault token create -policy=rewrap_example

step-6 create another token  APP_TOKEN=$(vault token create -format=json -policy=rewrap_example | jq -r ".auth.client_token")

step-7 echo $APP_TOKEN  [ to display token ]

## perform step on application server ##

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
    VAULT_ADDR=https://vault-01.examsimulator.net:8200 \
    VAULT_TRANSIT_KEY=my_app_key \
    SHOULD_SEED_USERS=true \
    dotnet run

```
step:10 final output 

![image](https://github.com/vijayendrar/devsecops/blob/main/Hashicorp/Vault/image/encryption.png)