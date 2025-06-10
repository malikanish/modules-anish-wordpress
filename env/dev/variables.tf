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
# variable "user_data_path" {}
variable "key_name" {}


# variable "public_subnet_id" {}

variable "ec2_name" {}
variable "asg_name" {}

variable "desired_capacity" {}
variable "max_size" {}
variable "min_size" {}

# variable "target_group_arn" {}


variable "lb_name" {}
# variable "security_group_id" {}
# variable "public_subnet_ids" {
#   type = list(string)
# }
variable "target_group_name" {}
# variable "vpc_id" {}






variable "sg_name" {
  description = "Name of the security group"
  type        = string
}
