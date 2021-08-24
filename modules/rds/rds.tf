resource "aws_db_subnet_group" "rds-subnet" {
  name       = "rds-subnet-group"
  subnet_ids = var.rds_subnets

  tags = var.rds_tags
}

resource "aws_db_instance" "rds-db" {
  allocated_storage    = 20
  storage_type         = "gp2"
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = var.db_instnace_class
  name                 = var.db_name
  username             = var.db_username
  password             = var.db_password
  parameter_group_name = "default.mysql5.7"
  db_subnet_group_name = aws_db_subnet_group.rds-subnet.name
  skip_final_snapshot  = true
  multi_az             = "false"
}

resource "aws_db_instance" "read_replica" {
  count               = var.create_read_replica == true ? 1 : 0
  replicate_source_db = aws_db_instance.rds-db.id
  instance_class = var.db_instnace_class
}