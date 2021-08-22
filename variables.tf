variable "region" {
    default = "eu-central-1"
}

variable "vpc_cidr" {
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

variable "account_no" {
  default = "224134489861"
}