terraform {
    required_providers {
        aws = {
            source = "hashicorp/aws"
            version = "~>4.16"
        }
    }

    required_version = ">= 1.2.0"
}

provider "aws" {
    region = "sa-east-1"
}

# ------------------------------------------------------------- #
# VPC
resource "aws_vpc" "my_vpc" {
    cidr_block = "10.2.0.0/16"
    enable_dns_support = true
    enable_dns_hostnames = true
}
# VPC
# ------------------------------------------------------------- #

# ------------------------------------------------------------- #
# Subnets
resource "aws_subnet" "my_internal_subnet_1" {
    vpc_id = aws_vpc.my_vpc.id
    cidr_block = "10.2.1.0/24"
    availability_zone = "sa-east-1a"
}

resource "aws_subnet" "my_public_subnet_1" {
    vpc_id = aws_vpc.my_vpc.id
    cidr_block = "10.2.2.0/24"
    availability_zone = "sa-east-1a"
}

resource "aws_subnet" "my_internal_subnet_2" {
    vpc_id = aws_vpc.my_vpc.id
    cidr_block = "10.2.3.0/24"
    availability_zone = "sa-east-1b"
}

resource "aws_subnet" "my_public_subnet_2" {
    vpc_id = aws_vpc.my_vpc.id
    cidr_block = "10.2.4.0/24"
    availability_zone = "sa-east-1b"
}
# Subnets
# ------------------------------------------------------------- #

# ------------------------------------------------------------- #
# Internet Gateway
resource "aws_internet_gateway" "my_igw" {
    vpc_id = aws_vpc.my_vpc.id
}
# Internet Gateway
# ------------------------------------------------------------- #

# ------------------------------------------------------------- #
# Route Tables
resource "aws_route_table" "my_internal_route_table" {
    vpc_id = aws_vpc.my_vpc.id
}

resource "aws_route_table" "my_public_route_table" {
    vpc_id = aws_vpc.my_vpc.id
}
# Route Tables
# ------------------------------------------------------------- #

# ------------------------------------------------------------- #
# Routes 
resource "aws_route" "my_external_route" {
    route_table_id = aws_route_table.my_public_route_table.id
    destination_cidr_block = "0.0.0.0/0"

    gateway_id = aws_internet_gateway.my_igw.id
}
# Routes 
# ------------------------------------------------------------- #

# ------------------------------------------------------------- #
# Route Tables Association
resource "aws_route_table_association" "my_external_route_table_1" {
    route_table_id = aws_route_table.my_public_route_table.id
    subnet_id = aws_subnet.my_public_subnet_1.id
}

resource "aws_route_table_association" "my_external_route_table_2" {
    route_table_id = aws_route_table.my_public_route_table.id
    subnet_id = aws_subnet.my_public_subnet_2.id
}
# Route Tables Association
# ------------------------------------------------------------- #

# ------------------------------------------------------------- #
# Security Group
resource "aws_security_group" "my_security_group" {
    name = "my_security_group"
    vpc_id = aws_vpc.my_vpc.id
    
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}
# Security Group
# ------------------------------------------------------------- #

resource "aws_instance" "app_server" {
    ami = "ami-0f16d0d3ac759edfa"
    instance_type = "t2.micro"

    
    subnet_id = aws_subnet.my_public_subnet_1.id
    vpc_security_group_ids = [aws_security_group.my_security_group.id]

    user_data = "apt update && apt install nginx -y"
}
