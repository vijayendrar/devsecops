<h3> Download file and place into one folder </h3>

![image](https://github.com/vijayendrar/devsecops/blob/main/Hashicorp/Terraform/images/docker%20cluster.jpg)

<h3>enter the digitaloceantoken in variable.tf according to your account </h3>

```hcl

variable "accesstoken" {
    type = string
    default = " " <<= place your token here
}

```

<h3> set the private key in variable.tf according to file location in your system </h3>

```hcl

variable "privatekey" {
    type = string
    default = "~/.ssh/id_rsa"
}

```

<h3>set the publickey in main.tf according to your environment </h4>

```hcl

resource "digitalocean_ssh_key" "default" {
    name = "Terraform Example"
    publickey = file ("c:/Users/sam/.ssh/id_rsa.pub")
}

```
