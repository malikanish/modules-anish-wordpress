variable "vpc_cidr_block" {}
variable "prefix_name" {}
variable "prefix_env" {}
variable "vpc_name" {}
variable "public_subnet_name" {}
variable "private_subnet_name" {}
variable "igw_name" {}
variable "route_table_name" {}
variable "default_route" {}
variable "subnet_count" {}
data "aws_availability_zones" "available" {
  state = "available"
}
variable "eip_name" {
  description = "Name of the Elastic IP resource"
  default     = "nat-eip"
}

variable "nat_gateway_name" {
  description = "Name of the NAT Gateway"
  default     = "nat-gw"
}

variable "private_route_table_name" {
  description = "Name of the private route table"
  default     = "private-rtb"
}

variable "launch_template_name" {}
variable "ami_id" {}
variable "instance_type" {}
variable "ec2_name" {}
variable "asg_name" {}

variable "desired_capacity" {}
variable "max_size" {}
variable "min_size" {}
variable "lb_name" {}
variable "target_group_name" {}
variable "sg_name" {
  description = "Name of the security group"
  type        = string
}
variable "db_instance_name" {

}


variable "cluster_name" {
  description = "Name of the ECS cluster"
  type        = string
}

# variable "ecs_ami_id" {
#   description = "ECS-optimized AMI ID"
#   type        = string
# }




variable "db_user" {}
variable "db_password" {}
variable "db_name" {}

