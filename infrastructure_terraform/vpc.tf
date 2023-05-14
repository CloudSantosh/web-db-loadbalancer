#Create VPC
resource "aws_vpc" "my_vpc" {

  # The CIDR block for the VPC.
  cidr_block = var.cidr_vpc

  # A boolean flag to enable/disable DNS support in the VPC.  
  enable_dns_support = true
  instance_tenancy   = "default"
  # A boolean flag to enable/disable DNS hostnames in the VPC. 
  enable_dns_hostnames = true

  tags = merge(
    var.additional_tags,
    {
      Name = "${var.name_prefix}-vpc"
    },
  )
}

#Create Public subnet #1
resource "aws_subnet" "public_sub2a" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = "192.168.0.0/24"
  map_public_ip_on_launch = true
  availability_zone       = var.availability_zone[0]

  tags = merge(
    var.additional_tags,
    {
      Name = "${var.name_prefix}-subnet-public1-${var.availability_zone[0]}"
    },
  )
}


#Create Public subnet #2
resource "aws_subnet" "public_sub2b" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = "192.168.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = var.availability_zone[1]

  tags = merge(
    var.additional_tags,
    {
      Name = "${var.name_prefix}-subnet-public2-${var.availability_zone[1]}"
    },
  )
}

#Create Private subnet #1
resource "aws_subnet" "db_private_sub2a" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = "192.168.2.0/24"
  map_public_ip_on_launch = false
  availability_zone       = var.availability_zone[0]


  tags = merge(
    var.additional_tags,
    {
      Name = "${var.name_prefix}-subnet-private1-${var.availability_zone[0]}"
    },
  )
}

#Create Private subnet #2
resource "aws_subnet" "db_private_sub2b" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = "192.168.3.0/24"
  availability_zone = var.availability_zone[1]

  tags = merge(
    var.additional_tags,
    {
      Name = "${var.name_prefix}-subnet-private2-${var.availability_zone[1]}"
    },
  )
}

#Create Internet gateway
resource "aws_internet_gateway" "my_igw" {
  vpc_id = aws_vpc.my_vpc.id

  tags = merge(
    var.additional_tags,
    {
      Name = "${var.name_prefix}-igw"
    },
  )
}

#Create Route Table for Public Subnets
resource "aws_route_table" "my_rt_table" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_igw.id
  }

  tags = merge(
    var.additional_tags,
    {
      Name = "${var.name_prefix}-rtb-public"
    },
  )
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
