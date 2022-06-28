## crate master node ##

resource "aws_instance" "k8-master" {
    ami = var.ami
    instance_type = var.instance_type
    vpc_security_group_ids = [ aws_security_group.sgmaster.id ]
    key_name = "Kubernetes-key"
    tags = {
      "Name" = "K8-master"
    }

    connection {
      type        = "ssh"
      host        = self.public_ip
      user        = "ubuntu"
      private_key = file("/home/ansible/.ssh/id_rsa")
    }

    provisioner "file" {
      source      = "master.sh"
      destination = "/tmp/master.sh"
    }  

    provisioner "remote-exec" {
      inline = [
        "chmod +x /tmp/master.sh",
        "/tmp/master.sh",       
      ]
    }

    provisioner "file" {
      source = "/home/ansible/.ssh/id_rsa.pub"
      destination = "/tmp/authorized_keys"
    }

    provisioner "remote-exec" {
      inline = [
        "sudo mv /tmp/authorized_keys  /home/ansible/.ssh/authorized_keys",
        "sudo chown -R ansible:ansible /home/ansible/.ssh/authorized_keys",       
      ]
    }

    provisioner "local-exec" {
      command = "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -u ansible --private-key /home/ansible/.ssh/id_rsa  -T 3000 -i '${aws_instance.k8-master.public_ip},', master.yml"  
    }
}

# resource "null_resource" "null_ansible" {
#   provisioner "local-exec" {
#     command = "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -u ansible --private-key /home/ansible/.ssh/id_rsa  -T 3000 -i '${aws_instance.k8-master.public_ip},', master.yml --start-at-task='Generate join command'"  
#   }
#   triggers =  {
#     always_run = timestamp()
#   }
# }

