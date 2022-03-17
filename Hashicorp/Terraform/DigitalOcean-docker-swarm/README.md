# Download file and place into one folder #

![image](https://github.com/vijayendrar/devsecops/blob/main/Hashicorp/Terraform/images/docker%20cluster.jpg)

## enter the digitaloceantoken in variable.tf according to your account ##

```hcl

variable "accesstoken" {
    type = string
    default = " " <<= place your token here
}

```

## set the private key in variable.tf according to file location in your system ##

```hcl

variable "privatekey" {
    type = string
    default = "~/.ssh/id_rsa"
}

```

## set the publickey in main.tf according to your environment ##

```hcl

resource "digitalocean_ssh_key" "default" {
    name = "Terraform Example"
    publickey = file ("c:/Users/sam/.ssh/id_rsa.pub")
}

```
