variable "accesstoken" {
    type = string
    default = "f561dad0b89de15587af621e201d9c883e1bffd06d8c3d59bb6920cb39fee9ca"
}

variable "machinename" {
    type = list(string)
    default = ["swarm-w1","swarm-w2","swarm-w3","swarm-w4"]
    
}

variable "instancecount" {
    type = number
    default = 4
}

variable "privatekey" {
    type = string
    default = "~/.ssh/id_rsa"
} 

