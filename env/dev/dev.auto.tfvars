
###prefix_START###

prefix_name = "Anish"
prefix_env  = "Dev"

###prefix_END###

###VPC_START###

vpc_name       = "VPC"
vpc_cidr_block = "10.0.0.0/16"

subnet_count = 2


public_subnet_name  = "Public-Subnet"
private_subnet_name = "Private-Subnet"
igw_name            = "IGW"
route_table_name    = "Public-RouteTable"
default_route       = "0.0.0.0/0"
###VPC_END###

launch_template_name = "ani-ec2-launch-template"
instance_type        = "t2.micro"

ec2_name = "anish-wordpress"
asg_name = "anish-autoscaling"

desired_capacity = 1
max_size         = 2
min_size         = 1

lb_name           = "anish-alb"
target_group_name = "anish-tg"

sg_name = "sg"

cluster_name = "Anish-cluster"

db_user          = "wpuser"
db_password      = "password"
db_name          = "wordpress"
db_instance_name = "anish-db-insatance"
