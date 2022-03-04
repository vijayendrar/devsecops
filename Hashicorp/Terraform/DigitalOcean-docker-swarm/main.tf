terraform {
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}

# configure the ditial ocean provider #
provider "digitalocean" {
  token = var.accesstoken
}

resource "digitalocean_ssh_key" "default" {
  name       = "Terraform Example"
  public_key = file("c:/Users/sam/.ssh/id_rsa.pub")
}



# Create a new Droplet #
resource "digitalocean_droplet" "swarm_manager" {
  image    = "ubuntu-18-04-x64"
  name     = "swarm-m1"
  region   = "blr1"
  size     = "s-1vcpu-2gb"  
  ssh_keys = [digitalocean_ssh_key.default.fingerprint]
 
 # connection to virtual machine instance #
   connection {
    type     = "ssh"
    user     = "root"
    host     = self.ipv4_address
    private_key = file(var.privatekey)
    agent = false
  }
# crate the file on remote machine #
  provisioner "file" {
    source = "script.sh"
    destination = "/tmp/script.sh"    
  }
# execcute the file code using inline command #
  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/script.sh",
      "/tmp/script.sh",         
    ]
  }

  provisioner "local-exec" {
    command = "ssh -i ${var.privatekey} -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null root@${self.ipv4_address} docker swarm join-token -q worker > token.txt"
  }
}

resource "digitalocean_droplet" "swarm-node" {
  image    = "ubuntu-18-04-x64"
  name     = var.machinename[count.index]
  region   = "blr1"
  size     = "s-1vcpu-2gb"
  count    = var.instancecount
  ssh_keys = [digitalocean_ssh_key.default.fingerprint]

    connection {
      type = "ssh"
      host = self.ipv4_address
      user = "root"
      private_key = file(var.privatekey)
    }

    provisioner "file" {
      source = "docker.sh"
      destination = "/tmp/docker.sh"    
    }

    provisioner "remote-exec" {
      inline = [
      "chmod +x /tmp/docker.sh",
      "/tmp/docker.sh", 
      "docker swarm join --token ${trimspace(file("token.txt"))} ${digitalocean_droplet.swarm_manager.ipv4_address_private}:2377"        
      ]
    }  
}

    output "swarm_manager_ip" {
    value = digitalocean_droplet.swarm_manager.ipv4_address
    }

    output "swarm_worker_ip-1" {
    value = digitalocean_droplet.swarm-node[0].ipv4_address
    }

    output "swarm_worker_ip-2" {
    value = digitalocean_droplet.swarm-node[1].ipv4_address
    }

    output "swarm_worker_ip-3" {
    value = digitalocean_droplet.swarm-node[2].ipv4_address
    }

    output "swarm_worker_ip-4" {
    value = digitalocean_droplet.swarm-node[3].ipv4_address
    }





