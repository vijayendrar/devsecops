resource "aws_security_group" "my-sg" {
    name = "my-sg"
    description = "allow port 22 and 80"
    vpc_id = aws_vpc.main.id


    ingress {
        description = "allow ssh port"
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        description = "allow http port"
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
       
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks= ["0.0.0.0/0"]
    }

    tags = {
        name = "allow https and ssh"
    }
}