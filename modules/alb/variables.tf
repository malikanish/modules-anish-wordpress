variable "lb_name" {}
variable "security_group_id" {}
variable "public_subnet_ids" {
  type = list(string)
}
variable "target_group_name" {}
variable "vpc_id" {}
