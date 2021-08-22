provider "aws" {
region = "us-east-1"
}

# Use S3 as backend instead of local
#terraform {
#  backend "s3" {
#    bucket         = "pbl-tf-backend"
#    key            = "global/s3/terraform.tfstate"
#    region         = "eu-central-1"
#    dynamodb_table = "terraform-locks"
#    encrypt        = true
#  }
#}

locals {
  default_tags = {
    Description = "Created by Terraform"
  }
}
# Create VPC
resource "aws_vpc" "main" {
  cidr_block                     = "172.16.0.0/16"
  enable_dns_support             = "true"
  enable_dns_hostnames           = "true"
  enable_classiclink             = "false"
  enable_classiclink_dns_support = "false"
  tags = merge(
    local.default_tags,
    {
      Name = "Terraform VPC"
    } 
  )
}

# Get list of availability zones
data "aws_availability_zones" "available" {
    state = "available"
}

 # Create public subnet1
resource "aws_subnet" "public" { 
    count                   = var.preferred_number_of_public_subnets == null ? length(data.aws_availability_zones.available.names) : var.preferred_number_of_public_subnets
    vpc_id                  = aws_vpc.main.id
    cidr_block              = cidrsubnet(var.vpc_cidr, 4 , count.index)
    map_public_ip_on_launch = true
    availability_zone       = data.aws_availability_zones.available.names[count.index]
    tags = merge(
      local.default_tags,
      {
      Name = format("PublicSubnet-%s", count.index)
      } 
    )
}

resource "aws_subnet" "private" { 
    count                   = var.preferred_number_of_private_subnets == null ? length(data.aws_availability_zones.available.names) : var.preferred_number_of_private_subnets
    vpc_id                  = aws_vpc.main.id
    cidr_block              = cidrsubnet(var.vpc_cidr, 4 , count.index+2)
    map_public_ip_on_launch = false
    availability_zone       = data.aws_availability_zones.available.names[count.index]
    tags = merge(
      local.default_tags,
      {
        Name = format("PrivateSubnet-%s", count.index)
      } 
    )
}