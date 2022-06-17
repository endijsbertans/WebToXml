# needed for Route Table
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id
  
  tags = {
    Name = "main"
  }
}
# Creates VPC
resource "aws_vpc" "main" {
  cidr_block       = "10.1.0.0/16"
  instance_tenancy = "default"
  enable_dns_hostnames = true
  tags = {
    Name = "main"
  }
}
#Creates 2 subnets for loadbalancer, with names Main and Main1
resource "aws_subnet" "subnet" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.1.16.0/20"
  availability_zone = "eu-north-1c"
  tags = {
    Name = "Main"
  }
}
 resource "aws_subnet" "subnet1" {
 vpc_id     = aws_vpc.main.id
 cidr_block = "10.1.32.0/20"
 availability_zone = "eu-north-1a"


   tags = {
     Name = "Main1"
   }
 }
 # Creates route table, for internet access
 resource "aws_route_table" "example" {
  vpc_id = aws_vpc.main.id

  route  {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.gw.id}"
  }

  tags = {
    Name = "example"
  }
  }
  
  resource "aws_main_route_table_association" "route_table_a" {
  vpc_id         = aws_vpc.main.id
  route_table_id = aws_route_table.example.id
}