output "cluster_name" {
  value = aws_ecs_cluster.this.name
}
output "cluster_id" {
  value = aws_ecs_cluster.this.id
}

output "ecs_instance_profile_name" {
  value = aws_iam_instance_profile.ecs_instance_profile.name
}