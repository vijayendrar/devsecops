resource "aws_security_group" "sg" {
  count = var.sgcount  
  name =  var.security_group_name [count.index]  
}

## Security Group Rule attache to SG-1 ##

resource "aws_security_group_rule" "rule-set-1" {
  count = length(var.rule1)
  type              = "ingress"
  from_port         = var.rule1[count.index].from_port
  to_port           = var.rule1[count.index].to_port
  protocol          = "tcp"
  cidr_blocks = [ var.rule1[count.index].cidr_blocks ]
  security_group_id = element(aws_security_group.sg.*.id, 0)
}

## Security Group Rule attache to SG-2 ##

resource "aws_security_group_rule" "rule-set-2" {
  count = length(var.rule2)
  type              = "ingress"
  from_port         = var.rule2[count.index].from_port
  to_port           = var.rule2[count.index].to_port
  protocol          = "tcp"
  cidr_blocks = [ var.rule2[count.index].cidr_blocks ]
  security_group_id = element(aws_security_group.sg.*.id, 1)
}

## Security Group Rule attache to SG-3 ##

resource "aws_security_group_rule" "rule-set-3" {
  count = length(var.rule3)
  type              = "ingress"
  from_port         = var.rule3[count.index].from_port
  to_port           = var.rule3[count.index].to_port
  protocol          = "tcp"
  cidr_blocks = [ var.rule3[count.index].cidr_blocks ]
  security_group_id = element(aws_security_group.sg.*.id, 2)
}