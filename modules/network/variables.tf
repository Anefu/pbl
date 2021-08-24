variable "region" {
    default = "us-east-1"
}

variable "vpc_cidr" {
    type = string
    default = "172.16.0.0/16"
}

variable "enable_dns_support" {
    default = "true"
}

variable "enable_dns_hostnames" {
    default ="true" 
}

variable "enable_classiclink" {
    default = "false"
}

variable "enable_classiclink_dns_support" {
    default = "false"
}

variable "preferred_number_of_public_subnets" {
    default = 2
}

variable "preferred_number_of_private_subnets" {
    default = 4
}

variable "environment" {
    default = "dev"
}

variable "bastion_ami" {
  default = "ami-0b0af3577fe5e3532"
}

variable "webserver_ami" {
  default = "ami-0b0af3577fe5e3532"
}

variable "images" {
    type = map
    default = {
        "us-east-1" = "ami-0b0af3577fe5e3532",
        "us-west-1" = "ami-054965c6cd7c6e462"
    }
}

variable "vpc_tags" {
  type = map
}

variable "public_subnet_tags" {
  type = map
}

variable "private_subnet_tags" {
  type = map
}

variable "nat_eip_tags" {
  type = map
}

variable "nat_tags" {
  type = map
}

variable "ig_tags" {
  type = map
}