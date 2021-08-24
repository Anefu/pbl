resource "aws_lb" "nginx-alb" {
  name     = "nginx-alb"
  internal = false
  security_groups = var.alb_security_group
  subnets = var.alb_subnet_ids
  tags = var.nginx_alb_tags
  ip_address_type    = "ipv4"
  load_balancer_type = "application"
}

resource "aws_lb_target_group" "nginx-tg" {
  health_check {
    interval            = 10
    path                = "/"
    protocol            = "HTTP"
    timeout             = 5
    healthy_threshold   = 5
    unhealthy_threshold = 2
  }

  name        = "nginx-tg"
  port        = 80
  protocol    = "HTTP"
  target_type = "instance"
  vpc_id      = var.vpc_id
}

resource "aws_lb_listener" "nginx-listener" {
  load_balancer_arn = aws_lb.nginx-alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.nginx-tg.arn
  }
}

resource "aws_lb" "wordpress-alb" {
  name     = "wordpress-alb"
  internal = true
  security_groups = var.alb_security_group
  subnets = var.alb_subnet_ids
  tags = var.wordpress_alb_tags
  ip_address_type    = "ipv4"
  load_balancer_type = "application"
}

resource "aws_lb_target_group" "wordpress-tg" {
  health_check {
    interval            = 10
    path                = "/"
    protocol            = "HTTP"
    timeout             = 5
    healthy_threshold   = 5
    unhealthy_threshold = 2
  }

  name        = "wordpress-tg"
  port        = 80
  protocol    = "HTTP"
  target_type = "instance"
  vpc_id      = var.vpc_id
}

resource "aws_lb_listener" "wordpress-listener" {
  load_balancer_arn = aws_lb.wordpress-alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.wordpress-tg.arn
  }
}

resource "aws_lb" "tooling-alb" {
  name     = "tooling-alb"
  internal = true
  security_groups = var.alb_security_group
  subnets = var.alb_subnet_ids
  tags = var.tooling_alb_tags
  ip_address_type    = "ipv4"
  load_balancer_type = "application"
}

resource "aws_lb_target_group" "tooling-tg" {
  health_check {
    interval            = 10
    path                = "/"
    protocol            = "HTTP"
    timeout             = 5
    healthy_threshold   = 5
    unhealthy_threshold = 2
  }

  name        = "tooling-tg"
  port        = 80
  protocol    = "HTTP"
  target_type = "instance"
  vpc_id      = var.vpc_id
}

resource "aws_lb_listener" "tooling-listener" {
  load_balancer_arn = aws_lb.tooling-alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tooling-tg.arn
  }
}

resource "aws_lb_target_group" "bastion-tg" {
  health_check {
    interval            = 10
    path                = "/"
    protocol            = "HTTP"
    timeout             = 5
    healthy_threshold   = 5
    unhealthy_threshold = 2
  }

  name        = "bastion-tg"
  port        = 80
  protocol    = "HTTP"
  target_type = "instance"
  vpc_id      = var.vpc_id
}
