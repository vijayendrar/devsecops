resource "aws_instance" "k8node" {
    count = var.k8nodecount
    ami = var.ami
    instance_type = var.instance_type
    vpc_security_group_ids = [ aws_security_group.sgnode.id ]
    key_name = "Kubernetes-key"
    depends_on = [
      aws_instance.k8-master
    ]
    tags = {
      Name = var.k8nodename[count.index]
    }

    connection {
      type        = "ssh"
      host        = self.public_ip
      user        = "ubuntu"
      private_key = file("/home/ansible/.ssh/id_rsa")      
    }

     provisioner "file" {
      source      = "node.sh"
      destination = "/tmp/node.sh"
    }  

    provisioner "remote-exec" {
      inline = [
        "chmod +x /tmp/node.sh",
        "/tmp/node.sh",       
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
}   

resource "null_resource" "node1null" {
    provisioner "local-exec" {    
        command = "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -u ansible --private-key /home/ansible/.ssh/id_rsa  -T 3000 -i '${aws_instance.k8node[0].public_ip},', node1.yml"       
    }    
}

resource "null_resource" "node2null" {
    provisioner "local-exec" {
        command = "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -u ansible --private-key /home/ansible/.ssh/id_rsa  -T 3000 -i '${aws_instance.k8node[1].public_ip},', node2.yml"

    }  
}