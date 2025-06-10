module "vpc" {
  source              = "../../modules/vpc"
  prefix_name         = var.prefix_name
  prefix_env          = var.prefix_env

  vpc_cidr_block      = var.vpc_cidr_block
  vpc_name            = var.vpc_name
  igw_name            = var.igw_name
  route_table_name    = var.route_table_name

  public_subnet_name  = var.public_subnet_name
  private_subnet_name = var.private_subnet_name
  subnet_count        = var.subnet_count
  default_route       = var.default_route

  eip_name                = var.eip_name
  nat_gateway_name        = var.nat_gateway_name
  private_route_table_name = var.private_route_table_name
}

module "autoscaling" {
  source = "../../modules/autoscaling"

  launch_template_name = var.launch_template_name
  ami_id               = var.ami_id
  instance_type        = var.instance_type
  key_name = module.db_ec2.key_name
  db_private_ip = module.db_ec2.db_instance_private_ip

  security_group_id    = module.sg.security_group_id
  public_subnet_ids    = module.vpc.public_subnet_ids
  target_group_arn = module.alb.target_group_arn

  ec2_name             = var.ec2_name
  asg_name             = var.asg_name

  desired_capacity     = var.desired_capacity
  max_size             = var.max_size
  min_size             = var.min_size
}

module "alb" {
  source             = "../../modules/alb"
  lb_name            = "anish-alb"
  target_group_name  = "anish-tg"
  vpc_id             = module.vpc.vpc_id
  security_group_id  = module.sg.security_group_id
  public_subnet_ids  = module.vpc.public_subnet_ids
}


module "sg" {
  source      = "../../modules/sg"
  vpc_id      = module.vpc.vpc_id
  prefix_name = var.prefix_name
  prefix_env  = var.prefix_env
  sg_name     = var.sg_name
}


module "db_ec2" {
  source = "../../modules/ec2_db"

  ami_id           = var.ami_id
  instance_type    = var.instance_type
  private_subnet_id = module.vpc.private_subnet_ids[0] 
  key_name         = var.key_name
  security_group_id = module.sg.security_group_id
  db_instance_name = "wordpress-db"
    public_key_path     = "/home/anish/Downloads/ani-key.pub"

}
