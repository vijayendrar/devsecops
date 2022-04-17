resource "aws_instance" "myinstance" {
    ami = var.ami_image
    instance_type = var.instance-type
    key_name = "myKey"
    count = var.mastercount
    associate_public_ip_address = "true" 
    vpc_security_group_ids = [aws_security_group.my-sg.id]    
    subnet_id = element(aws_subnet.public_subnet.*.id, count.index)
    tags = {
      Name = var.instancetag[count.index]
    }  
    user_data = <<EOF
    #!/bin/bash
    sudo yum update -y
    sudo yum install httpd -y 
    sudo systemctl enable httpd
    cd /var/www/html
    sudo sh -c "echo '<html><body>IP address of this instance:' > index.html"
    sudo sh -c "curl http://169.254.169.254/latest/meta-data/public-ipv4 >> index.html"
    sudo sh -c "echo '</body></html>' >> index.html"
    sudo systemctl start httpd.service
    EOF     
}