variable "accesstoken" {
    type = string
    default = " "
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

