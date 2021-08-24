variable "rds_subnets" {
  type = list
}
variable "rds_tags" {
  type = map
}
variable "db_name" {
  type = string
  description = "Name of the database to create"
}
variable "db_password" {
  type = string
}
variable "db_username" {
  type = string
}
variable "create_read_replica" {
  type = bool
  default = false
}
variable "db_instnace_class" {
  type = string
  default = "db.t2.micro"
}