resource "aws_s3_bucket" "s3_bucket" {
  bucket = "ninox-bucket"

  tags = {
    Name        = "Ninox Bucket"
    Environment = "Dev"
    vpc         = aws_vpc.new_vpc.id     # created a custome VPC and S3 with implict dependecy
  }

}

resource "aws_s3_bucket_versioning" "s3_bucket_versioning" {
  bucket = aws_s3_bucket.s3_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}



resource "aws_vpc" "new_vpc" {
  cidr_block           = var.Cidrs
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name        = "new_vpc"
    environment = "Dev"
  }
}


resource "aws_subnet" "public_subnet" {
  count             = length(var.public_subnet_cidrs)
  vpc_id            = aws_vpc.new_vpc.id
  cidr_block        = var.public_subnet_cidrs[count.index]
  availability_zone = var.Availability_zones[count.index]

  tags = {
    Name        = "public_subnet_${count.index + 1}"
    environment = "Dev"
  }
}

resource "aws_subnet" "private_subnet" {
  count             = length(var.private_subnet_cidrs)
  vpc_id            = aws_vpc.new_vpc.id
  cidr_block        = var.private_subnet_cidrs[count.index]
  availability_zone = var.Availability_zones[count.index]

  tags = {
    Name        = "private_subnet_${count.index + 1}"
    environment = "Dev"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.new_vpc.id

  tags = {
    Name        = "new_igw"
    environment = "Dev"
  }
}

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.new_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name        = "public_route_table"
    environment = "Dev"
  }
}

resource "aws_route_table_association" "public_route_table_association" {
  count          = length(var.public_subnet_cidrs)
  subnet_id      = aws_subnet.public_subnet[count.index].id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_eip" "nat_eip" {
  domain = "vpc"

  tags = {
    Name        = "nat_eip"
    environment = "Dev"
  }
}

resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public_subnet[0].id

  tags = {
    Name        = "nat_gw"
    environment = "Dev"
  }
}

resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.new_vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gw.id
  }

  tags = {
    Name        = "private_route_table"
    environment = "Dev"
  }
}

resource "aws_route_table_association" "private_route_table_association" {
  count          = length(var.private_subnet_cidrs)
  subnet_id      = aws_subnet.private_subnet[count.index].id
  route_table_id = aws_route_table.private_route_table.id
}


resource "aws_security_group" "web_sg" {
  name        = "webapp_sg"
  description = "Allows APP traffic"
  vpc_id      = aws_vpc.new_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "web_sg"
    Environment = "Dev"
  }
}


