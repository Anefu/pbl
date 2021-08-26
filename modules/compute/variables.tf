variable "bastion_ami" {
  default = "ami-0b0af3577fe5e3532"
}
variable "security_groups" {
  type = list
}
variable "instance_type" {
  type = string
  default = "t2.micro"
}
variable "subnet_id" {
  type = string
}