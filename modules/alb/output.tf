output "alb_arn" {
  description = "Application Load Balancer ARN"
  value       = aws_lb.this.arn
}

output "alb_dns_name" {
  description = "Application Load Balancer DNS Name"
  value       = aws_lb.this.dns_name
}

output "target_group_arn" {
  description = "Target Group ARN"
  value       = aws_lb_target_group.this.arn
}
