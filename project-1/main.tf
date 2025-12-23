provider "aws" {
    region ="us-east-1"
  
}
#creating the aws vpc
resource "aws_vpc" "myvpc" {
    cidr_block = "10.0.0.0/24"
    enable_dns_hostnames = true
    enable_dns_support = true
    tags = {
      Name = "ggvpc"
    }
}

resource "aws_subnet" "public-subnet" {
    cidr_block = "10.0.0.0/25"
    vpc_id = aws_vpc.myvpc.id
    availability_zone = "us-east-1a"
    map_public_ip_on_launch = true  
  tags = {
    Name ="public-subnet1"
  }
}

resource "aws_subnet" "public-subent2" {
    cidr_block = "10.0.0.128/25"
    vpc_id = aws_vpc.myvpc.id
    availability_zone = "us-east-1b"
    map_public_ip_on_launch = true

    tags = {
      Name = "pubic-subnet2"
    }
  
}

resource "aws_internet_gateway" "IGW" {
    vpc_id = aws_vpc.myvpc.id

    tags = {
      Name = "MyIGW"
    }
  
}

resource "aws_route_table" "RT" {
    vpc_id = aws_vpc.myvpc.id

    tags = {
      Name = "public-RT"
    }
}
resource "aws_route" "rout" {
    route_table_id = aws_route_table.RT.id
    destination_cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.IGW.id
}

resource "aws_route_table_association" "public-subnet-aws_route_table_association" {
    subnet_id = aws_subnet.public-subnet.id
    route_table_id = aws_route_table.RT.id
  
}
