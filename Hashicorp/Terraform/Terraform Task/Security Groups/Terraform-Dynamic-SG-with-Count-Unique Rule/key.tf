resource "aws_key_pair" "my-key" {
    key_name = "my-key" 
<<<<<<< HEAD
    public_key = file("/vagrant/CKA/id_rsa.pub")
=======
    public_key = file("C:/Users/Sam/.ssh/id_rsa.pub")
>>>>>>> 0cd2ebb694b7353aef50ba199590c53e33d3e657
}