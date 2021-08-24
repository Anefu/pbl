variable "bastion_ami" {
  type = string
  default = "ami-0b0af3577fe5e3532"
}
variable "bastion_sg" {
  type = list
}
variable "instance_type" {
  type = string
  default = "t2.micro"
}
variable "bastion_subnets" {
  type = list
}
variable "bastion_tg_arn" {
  type = list
}