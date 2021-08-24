variable "bastion_ami" {
  default = "ami-0b0af3577fe5e3532"
}
# variable "subnets-compute" {}
# variable "ami-bastion" {}
# variable "ami-nginx" {}
# variable "ami-webserver" {}
# variable "sg-compute" {}
variable "security_groups" {
  type = list
}
variable "instance_type" {
  type = string
}
variable "subnet_id" {
  type = string
}