
resource "aws_launch_template" "ani_ec2_launch_templ" {
  name_prefix   = var.launch_template_name
  image_id      = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name

user_data = base64encode(templatefile("${path.module}/ecs.sh", {
  cluster_name = var.cluster_name
}))

iam_instance_profile {
  name = var.ecs_instance_profile_name
}


  network_interfaces {
    security_groups = [var.security_group_id]
  }

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = var.ec2_name
    }
  }
}

# 5. Auto Scaling Group
resource "aws_autoscaling_group" "ani_asg" {
  desired_capacity     = var.desired_capacity
  max_size             = var.max_size
  min_size             = var.min_size

  vpc_zone_identifier  = var.public_subnet_ids
  target_group_arns    = [var.target_group_arn]

  launch_template {
    id      = aws_launch_template.ani_ec2_launch_templ.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = var.asg_name
    propagate_at_launch = true
  }

  health_check_type         = "EC2"
  health_check_grace_period = 300
}

resource "aws_autoscaling_policy" "target_tracking" {
  name                   = "target-tracking-policy"
  autoscaling_group_name = aws_autoscaling_group.ani_asg.id
  policy_type            = "TargetTrackingScaling"

  target_tracking_configuration {
    target_value = 50.0

    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }
  }
}
