resource "aws_instance" "Amazon_linux" {    
    ami = "ami-0022f774911c1d690"
    availability_zone = var.AZ[count.index]
    key_name = "my-key"  
    instance_type = var.instancetype
    vpc_security_group_ids = [ element(aws_security_group.sg.*.id, count.index) ]
    #security_groups = [ ]
    count = var.instancecount

    tags = {
      Name = var.nodename[count.index]
    }
}

