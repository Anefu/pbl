resource "aws_launch_template" "BastionLT" {
    name = "BastionLT"
    image_id = var.bastion_ami
    vpc_security_group_ids = var.bastion_sg
    user_data = base64encode(
        <<EOF
        #!/bin/bash
        yum update -y
        yum install -y ansible git
        EOF
    )
    instance_type = var.instance_type
    lifecycle {
      create_before_destroy = true
    }
}

resource "aws_autoscaling_group" "Bastion_asg" {
  vpc_zone_identifier  = var.bastion_subnets
  target_group_arns    = var.bastion_tg_arn
  health_check_type    = "EC2"

  min_size = 2
  max_size = 10

  launch_template {
    id = aws_launch_template.BastionLT.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "Bastion-asg"
    propagate_at_launch = true
  }
}
