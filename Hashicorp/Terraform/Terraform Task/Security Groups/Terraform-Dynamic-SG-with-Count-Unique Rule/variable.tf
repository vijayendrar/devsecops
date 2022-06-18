variable "security_group_name" {
  type = list(string)
  default = ["SG-1","SG-2","SG-3"]  
}


variable "region" {
  type = string
  default = "us-east-1"  
}

variable "AZ" {
  type = list(string)
  default = [ "us-east-1a","us-east-1b","us-east-1c"]    
}

variable "instancetype" {
  type = string
  default = "t2.micro"  
}

variable "instancecount" {
  type = number
  default = 3
}

variable "nodename" {
  type = list(string)
  default = [ "Node-1","Node-2","Node-3"]    
}

variable "sgcount" {
  type = number
  default = 3  
}

variable "rule1" {
  type = list(object({
    from_port = number
    to_port = number
    cidr_blocks = string
  }))

  default = [
    {
      from_port = 22
      to_port = 22
      cidr_blocks = "192.168.2.0/24"
    },
    {
      from_port = 8080
      to_port = 8080
      cidr_blocks = "192.168.3.0/24"
    },  
  ]
}


variable "rule2" {
  type = list(object({
    from_port = number
    to_port = number
    cidr_blocks = string
  }))

  default = [
    {
      from_port = 9090
      to_port = 9090
      cidr_blocks = "192.168.5.0/24"
    },
    {
      from_port = 4500
      to_port = 4500
      cidr_blocks = "192.168.5.0/24"
    },  
  ]
}

variable "rule3" {
  type = list(object({
    from_port = number
    to_port = number
    cidr_blocks = string
  }))

  default = [
    {
      from_port = 6000  
      to_port = 6000
      cidr_blocks = "192.168.20.0/24"
    },
    {
      from_port = 5000  
      to_port = 5000
      cidr_blocks = "192.168.30.0/24"
    },  
  ]
}