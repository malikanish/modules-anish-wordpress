variable "prefix_name" {}
variable "launch_template_name" {}
variable "ami_id" {}
variable "instance_type" {}
variable "key_name" {}
variable "cluster_name" {}
variable "public_subnet_ids" {
  type = list(string)
}
variable "security_group_id" {}
variable "target_group_arn" {}
variable "asg_name" {}
variable "desired_capacity" {}
variable "min_size" {}
variable "max_size" {}
variable "ec2_name" {
  
}

variable "ecs_instance_profile_name" {
  description = "IAM instance profile name for ECS EC2"
  type        = string
}
