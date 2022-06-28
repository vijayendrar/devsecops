variable "environment" {
  default = "public"  
}

variable "private" {
  default = "private"
}

variable "vpc" {
    type = string
    default = "10.0.0.0/16"
}

variable "private_subnet" {
  type    = list(string)
  default = ["10.0.4.0/24","10.0.5.0/24","10.0.6.0/24"]
}

variable "public_subnet" {
  type    = list(string)
  default = ["10.0.1.0/24","10.0.2.0/24","10.0.3.0/24"]
}

variable "ami_image" {
  type = string
  default = "ami-03ededff12e34e59e"  
}


variable "instance-type" {
  type = string
  default = "t2.micro"  
}

variable "mastercount" {
  type    = number
  default = "3"
}

variable "instancetag" {
  type    = list(string)
  default = ["Machine-1", "Machine-2", "machine-3"]
}

variable "az" {
  type    = list(string)
  default = ["us-east-1a", "us-east-1b", "us-east-1c"]
}
