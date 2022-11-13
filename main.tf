terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region     = "us-west-1"
  access_key = ""
  secret_key = ""

}

resource "aws_vpc" "MatanMaman-dev-vpc" { 
    cidr_block = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "Matan-Maman-dev-vpc"
  }
  
}

resource "aws_internet_gateway" "igw_Matan" {
    vpc_id = aws_vpc.MatanMaman-dev-vpc.id
     tags = {
    Name = "Matan-Maman-igw"
     }
}
     resource "aws_route" "routeRL" {
  route_table_id         = aws_vpc.MatanMaman-dev-vpc.main_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw_Matan.id
}
resource "aws_subnet" "MatanMaman-k8s-subnet" {
  vpc_id = aws_vpc.MatanMaman-dev-vpc.id
  cidr_block = "10.0.0.0/27"
  availability_zone = "us-west-1a"
    tags = {
    Name = "MatanMaman-k8s-subnet"
     }
  
}
