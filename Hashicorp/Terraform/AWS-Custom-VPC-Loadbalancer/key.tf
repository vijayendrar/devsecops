resource "tls_private_key" "pk" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "kp" {
  key_name   = "myKey"       # Create "myKey" to AWS!!
  public_key = tls_private_key.pk.public_key_openssh
}  

  resource "local_file" "mykey_pem" {
    filename = "${path.module}/my-key.pem"
    content = tls_private_key.pk.private_key_pem  
}
