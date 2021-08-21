resource "aws_launch_template" "BastionLT" {
    name = "BastionLT"
    image_id = var.bastion_ami
    vpc_security_group_ids = [aws_security_group.bastion_sg.id]
    user_data = base64encode(
        <<EOF
        #!/bin/bash
        yum update -y
        yum install -y ansible git
        EOF
    )
    instance_type = "t2.micro"
    lifecycle {
      create_before_destroy = true
    }
}

resource "aws_autoscaling_group" "Bastion_asg" {
  vpc_zone_identifier  = [
    aws_subnet.public[0].id,
    aws_subnet.public[1].id
  ]
  target_group_arns    = [aws_lb_target_group.my-target-group.arn]
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

resource "aws_autoscaling_group" "private_asg" {
  launch_template {
    id = aws_launch_template.BastionLT.id
    version = "$Latest"
  }
  vpc_zone_identifier  = [
    aws_subnet.private[0].id,
    aws_subnet.private[1].id
  ]
  target_group_arns    = [aws_lb_target_group.private-target-group.arn]
  health_check_type    = "EC2"
  min_size = 2
  max_size = 10

  tag {
    key                 = "Name"
    value               = "private_asg"
    propagate_at_launch = true
  }
}