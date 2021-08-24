variable "alb_security_group" {
  type = list
}
variable "alb_subnet_ids" {
  type = list
}
variable "nginx_alb_tags" {
  type = map
}
variable "vpc_id" {
  type = string
}
variable "wordpress_alb_tags" {
  type = map
}
variable "tooling_alb_tags" {
  type = map
}