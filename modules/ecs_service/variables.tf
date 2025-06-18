variable "cluster_id" {}
variable "db_host" {}
variable "target_group_arn" {
  description = "ARN of the Target Group to register the ECS service"
  type        = string
}
