variable "launch_template_name" {
  description = "Prefix for the launch template name"
  type        = string
}

variable "ami_id" {
  description = "AMI ID for EC2 instances"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}

# variable "user_data_path" {
#   description = "Path to the user data script"
#   type        = string
# }

variable "key_name" {
  description = "Key pair name for SSH access"
  type        = string
}

variable "security_group_id" {
  description = "Security group ID for EC2"
  type        = string
}

variable "public_subnet_ids" {
  description = "List of public subnet IDs where EC2s will launch"
  type        = list(string)
}

variable "target_group_arn" {
  description = "ARN of the target group for ALB"
  type        = string
}

variable "ec2_name" {
  description = "Tag name for EC2 instances"
  type        = string
}

variable "asg_name" {
  description = "Name for the Auto Scaling Group"
  type        = string
}

variable "desired_capacity" {
  description = "Desired number of instances"
  type        = number
}

variable "max_size" {
  description = "Maximum number of instances"
  type        = number
}

variable "min_size" {
  description = "Minimum number of instances"
  type        = number
}

variable "db_private_ip" {
  type = string
}

