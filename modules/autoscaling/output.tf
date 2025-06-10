output "autoscaling_group_name" {
  description = "Auto Scaling Group Name"
  value       = aws_autoscaling_group.ani_asg.name
}

output "autoscaling_group_id" {
  description = "Auto Scaling Group ID"
  value       = aws_autoscaling_group.ani_asg.id
}
