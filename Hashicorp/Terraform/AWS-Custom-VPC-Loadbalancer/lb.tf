resource "aws_lb_target_group" "my-target-group" {
    name = "TG-1"  
    target_type = "instance"
    port = 80
    protocol = "HTTP"   
    vpc_id = aws_vpc.main.id  
}

resource "aws_lb_target_group_attachment" "aws-instance-attach" {
  count = length(aws_instance.myinstance)  
  target_group_arn = aws_lb_target_group.my-target-group.arn
  target_id        = aws_instance.myinstance[count.index].id
  port             = 80
}

resource "aws_lb" "ALB" {
    name = "my-load-balancer"   
    internal = false
    load_balancer_type = "application"
    security_groups = [ aws_security_group.my-sg.id ]    
    subnets = aws_subnet.public_subnet.*.id

    tags = {
      Environment = "production"
    }
}


resource "aws_lb_listener" "my-listenr" {
    load_balancer_arn = aws_lb.ALB.arn
    port = "80"
    protocol = "HTTP"

    default_action {
      type = "forward"
      target_group_arn = aws_lb_target_group.my-target-group.arn
    }
  
}

