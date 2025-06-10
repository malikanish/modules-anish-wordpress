variable "vpc_cidr_block" {}
variable "prefix_name" {}
variable "prefix_env" {}
variable "vpc_name" {}
variable "subnet_count" {}           
variable "public_subnet_name" {}
variable "private_subnet_name" {}
variable "igw_name" {}
variable "route_table_name" {}
variable "default_route" {}
data "aws_availability_zones" "available" {
  state = "available"
}


variable "eip_name" {
  default = "nat-eip"
}

variable "nat_gateway_name" {
  default = "nat-gw"
}

variable "private_route_table_name" {
  default = "private-rtb"
}
