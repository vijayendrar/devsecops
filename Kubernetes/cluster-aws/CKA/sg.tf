resource "aws_security_group" "sgmaster" {
   name = "kubernetes-master-sg"
}

## Security Group Rule attache to SGMaster ##

resource "aws_security_group_rule" "rule-set-1" {
  count = length(var.rule1)
  type              = "ingress"
  from_port         = var.rule1[count.index].from_port
  to_port           = var.rule1[count.index].to_port
  protocol          = "tcp"
  description = var.rule1[count.index].description
  cidr_blocks = [ var.rule1[count.index].cidr_blocks ]
  security_group_id = aws_security_group.sgmaster.id
}

resource "aws_security_group_rule" "rule1-egress" {  
  type              = "egress"
  to_port           = 0
  protocol          = "-1"  
  from_port         = 0
  cidr_blocks = [ "0.0.0.0/0" ]
  security_group_id = aws_security_group.sgmaster.id
}


resource "aws_security_group" "sgnode" {
   name = "kubernetes-node-sg"
}

resource "aws_security_group_rule" "rule-set-2" {
  count = length(var.rule2)
  type              = "ingress"
  from_port         = var.rule2[count.index].from_port
  to_port           = var.rule2[count.index].to_port
  protocol          = "tcp"
  description       = var.rule2[count.index].description
  cidr_blocks = [ var.rule2[count.index].cidr_blocks ]
  security_group_id = aws_security_group.sgnode.id
}

resource "aws_security_group_rule" "rule2-egress" {
  type              = "egress"
  to_port           = 0
  protocol          = "-1"  
  from_port         = 0
  cidr_blocks = [ "0.0.0.0/0" ]
  security_group_id = aws_security_group.sgnode.id
}