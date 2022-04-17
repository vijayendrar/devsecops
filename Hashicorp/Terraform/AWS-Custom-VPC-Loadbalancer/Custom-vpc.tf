resource "aws_vpc" "main" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "main"
  }
}

resource "aws_subnet" "public_subnet" {
  vpc_id     = aws_vpc.main.id
  count = length(var.public_subnet) 
  cidr_block = element(var.public_subnet,count.index)
  availability_zone = element(var.az,count.index)
  tags = {
    Name = "${var.environment}-${element(var.az,count.index)}-public-subnet"
  }
}

resource "aws_subnet" "private_subnet" {
  vpc_id     = aws_vpc.main.id
  count = length(var.private_subnet) 
  cidr_block = element(var.private_subnet,count.index)
  availability_zone = element(var.az,count.index)

  tags = {
    Name = "${var.private}-${element(var.az,count.index)}-private-subnet"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "mygateway"
  }
}

resource "aws_route_table" "mytable" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
 
  tags = {
    Name        = "${var.environment}-public-route-table"
    Environment = "${var.environment}"
  }
}
resource "aws_route_table_association" "public-subnet" {
  count = length(var.public_subnet)
  subnet_id      = element(aws_subnet.public_subnet.*.id,count.index)
  route_table_id = aws_route_table.mytable.id
}