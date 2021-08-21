resource "aws_security_group" "alb-sg" {
  name   = "alb-sg"
  vpc_id = aws_vpc.main.id
  ingress {
    cidr_blocks = [ "0.0.0.0/0" ]
    description = "ALB security group"
    from_port = 80
    protocol = "HTTP"
    to_port = 80
    self = false
  }
  ingress {
    cidr_blocks = [ "0.0.0.0/0" ]
    description = "ALB security group"
    from_port = 443
    protocol = "HTTPS"
    to_port = 443
    self = false
  }
  egress {
    cidr_blocks = [ "0.0.0.0/0" ]
    from_port = 0
    protocol = "-1"
    to_port = 0
    self = false
  }
  tags = {
      Name = "ALB-SG"
      Environment = var.environment
  } 
}
resource "aws_security_group" "nginx-sg" {
  name   = "nginx-sg"
  vpc_id = aws_vpc.main.id
  ingress {
    from_port = 80
    to_port = 80
    protocol = "HTTP"
    security_groups = [aws_security_group.alb-sg.id]
  }
  ingress {
    from_port = 443
    to_port = 443
    protocol = "HTTPS"
    security_groups = [aws_security_group.alb-sg.id]
  }
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "NGINX-SG"
    Environment = var.environment
  }
}
resource "aws_security_group" "bastion_sg" {
    name = "vpc_web_sg"
    description = "Allow incoming SSH connections."

    ingress {
        description = "SSH"
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    vpc_id = aws_vpc.main.id

    tags = {
        Name = "Bastion-SG"
        Environment = var.environment
    }
}

resource "aws_security_group" "web_sg" {
  name   = "nginx-sg"
  vpc_id = aws_vpc.main.id
  ingress {
    from_port = 80
    to_port = 80
    protocol = "HTTP"
    security_groups = [aws_security_group.nginx-sg.id]
  }
  ingress {
    from_port = 443
    to_port = 443
    protocol = "HTTPS"
    security_groups = [aws_security_group.nginx-sg.id]
  }
  tags = {
    Name = "Webserver-SG"
    Environment = var.environment
  }
}

resource "aws_security_group" "EFS-SG" {
  vpc_id      = aws_vpc.main.id
  name        = "EFS-SG"
  description = "Allow NFS Traffic"

  ingress {
    from_port   = "2049"
    to_port     = "2049"
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr]
  }
  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = [var.vpc_cidr]
  }

  tags =  {
    Name = "efs-SG"
  }

}

resource "aws_security_group" "myapp_mysql_rds" {
  name        = "secuirty_group_web_mysqlserver"
  description = "Allow access to MySQL RDS"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port = 3306
    to_port = 3306
    protocol = "tcp"
    security_groups = [aws_security_group.web_sg.id]
  }

  tags = {
    Name = "rds_secuirty_group"
  }

}
