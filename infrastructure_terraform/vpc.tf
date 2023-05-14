#Create VPC
resource "aws_vpc" "my_vpc" {
  cidr_block       = var.cidr_vpc
  instance_tenancy = "default"

  tags = {
    Name = "my-vpc"
  }
}

#Create Public subnet #1
resource "aws_subnet" "public_sub2a" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = "192.168.0.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-west-2a"

  tags = {
    Name = "frontEnd_Public_sub2a"
  }
}

#Create Public subnet #2
resource "aws_subnet" "public_sub2b" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = "192.168.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-west-2b"

  tags = {
    Name = "frontend-public-sub2b"
  }
}

#Create Private subnet #1
resource "aws_subnet" "db_private_sub2a" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = "192.168.2.0/24"
  map_public_ip_on_launch = false
  availability_zone       = "us-west-2a"

  tags = {
    Name = "db_private_sub2a"
  }
}

#Create Private subnet #2
resource "aws_subnet" "db_private_sub2b" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = "192.168.3.0/24"
  availability_zone = "us-west-2b"

  tags = {
    Name = "db_private_sub2b"
  }
}

#Create Internet gateway
resource "aws_internet_gateway" "my_igw" {
  vpc_id = aws_vpc.my_vpc.id

  tags = {
    Name = "main_IGW"
  }
}

#Create Route Table for Public Subnets
resource "aws_route_table" "my_rt_table" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_igw.id
  }

  tags = {
    Name = "My_Route_Table"
  }
}

#Associate public subnets with routing table
resource "aws_route_table_association" "Public_sub1_Route_Association" {
  subnet_id      = aws_subnet.public_sub2a.id
  route_table_id = aws_route_table.my_rt_table.id
}

resource "aws_route_table_association" "Public_sub2_Route_Association" {
  subnet_id      = aws_subnet.public_sub2b.id
  route_table_id = aws_route_table.my_rt_table.id
}
