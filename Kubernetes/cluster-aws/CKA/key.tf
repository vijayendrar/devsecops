resource "aws_key_pair" "k8-key" {
  key_name   = "Kubernetes-key"
  public_key = file("/home/ansible/.ssh/id_rsa.pub")
}