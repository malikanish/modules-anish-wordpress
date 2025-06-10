variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}

variable "prefix_name" {
  description = "Prefix name for resources"
  type        = string
}

variable "prefix_env" {
  description = "Environment name"
  type        = string
}

variable "sg_name" {
  description = "Name of the security group"
  type        = string
}
