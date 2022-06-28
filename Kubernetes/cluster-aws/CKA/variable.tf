variable "region" {
  type = string
  default = "us-east-1"
}

variable "ami" {
  type = string
  default = "ami-08d4ac5b634553e16"  
}

variable "instance_type" {
  type = string
  default = "t2.medium"
  
}

variable "k8nodecount" {
  type = number
  default = 2

}

variable "k8nodename" {
  type = list(string)
  default = ["k8-node1","k8-node2"]  
}

variable "rule1" {
  type = list(object({
    from_port = number
    to_port = number
    description = string
    cidr_blocks = string
  }))

  default = [
    {
      from_port = 6443
      to_port = 6443
      description = "Kubernetes API server"
      cidr_blocks = "0.0.0.0/0"
    },
    {
      from_port = 2379
      to_port = 2380
      description = "etcd server client API"
      cidr_blocks = "0.0.0.0/0"
    },   
    {
      from_port = 10250
      to_port = 10250
      description = "Kubelet API"
      cidr_blocks = "0.0.0.0/0"
    },
    {
      from_port = 10259
      to_port = 10259
      description = "kube-scheduler"
      cidr_blocks = "0.0.0.0/0"
    },
    {
      from_port = 10257
      to_port = 10257
      description = "kube-controller-manager"
      cidr_blocks = "0.0.0.0/0"
    },
    {
      from_port = 22
      to_port = 22
      description = "Allow SSH"
      cidr_blocks = "0.0.0.0/0"
    },
  ]
}

variable "rule2" {
  type = list(object({
    from_port = number
    to_port = number
    description = string
    cidr_blocks = string
  }))

  default = [
    {
      from_port = 10250
      to_port = 10250
      description = "Kubelet API"
      cidr_blocks = "0.0.0.0/0"
    },
    {
      from_port = 30000
      to_port = 32767
      description = "NodePort Services"
      cidr_blocks = "0.0.0.0/0"
    },
    {
      from_port = 22
      to_port = 22
      description = "Allow SSH"
      cidr_blocks = "0.0.0.0/0"
    },    
  ]
}

variable "rule1egress" {
  type = list(object({
    from_port = number
    to_port = number
    description = string
    cidr_blocks = string
  }))

  default = [
    {
      from_port = 0
      to_port = 0
      description = "Allow All traffic"
      cidr_blocks = "0.0.0.0/0"
    }, 
   
  ]
}