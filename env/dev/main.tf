module "vpc" {
  source      = "../../modules/vpc"
  prefix_name = var.prefix_name
  prefix_env  = var.prefix_env

  vpc_cidr_block   = var.vpc_cidr_block
  vpc_name         = var.vpc_name
  igw_name         = var.igw_name
  route_table_name = var.route_table_name

  public_subnet_name  = var.public_subnet_name
  private_subnet_name = var.private_subnet_name
  subnet_count        = var.subnet_count
  default_route       = var.default_route

  eip_name                 = var.eip_name
  nat_gateway_name         = var.nat_gateway_name
  private_route_table_name = var.private_route_table_name
}

module "autoscaling" {
  source = "../../modules/autoscaling"

  prefix_name          = var.prefix_name
  launch_template_name = var.launch_template_name
  ami_id               = data.aws_ssm_parameter.ecs_ami.value
  instance_type        = var.instance_type
  key_name             = module.keypair.key_name
  security_group_id    = module.sg_wp.wp_sg_id
  public_subnet_ids    = module.vpc.public_subnet_ids
  target_group_arn     = module.alb.target_group_arn

  ec2_name = var.ec2_name
  asg_name = var.asg_name

  desired_capacity = var.desired_capacity
  max_size         = var.max_size
  min_size         = var.min_size

  cluster_name              = module.ecs_cluster.cluster_name
  ecs_instance_profile_name = module.ecs_cluster.ecs_instance_profile_name
}

module "alb" {
  source            = "../../modules/alb"
  lb_name           = var.lb_name
  target_group_name = var.target_group_name
  vpc_id            = module.vpc.vpc_id
  security_group_id = module.sg_alb.alb_sg_id
  public_subnet_ids = module.vpc.public_subnet_ids
}

data "aws_ssm_parameter" "ecs_ami" {
  name = "/aws/service/ecs/optimized-ami/amazon-linux-2/recommended/image_id"
}


module "db_ec2" {
  source = "../../modules/ec2_db"

  ami_id            = var.ami_id
  instance_type     = var.instance_type
  private_subnet_id = module.vpc.private_subnet_ids[0]
  key_name          = module.keypair.key_name
  db_instance_name  = var.db_instance_name

  security_group_id = module.sg_db.db_sg_id
}

module "ecs_service" {
  source     = "../../modules/ecs_service"
  cluster_id = module.ecs_cluster.cluster_id

  db_host          = module.db_ec2.db_instance_private_ip
  target_group_arn = module.alb.target_group_arn
}

module "ecs_cluster" {
  source       = "../../modules/ecs-cluster"
  prefix_name  = var.prefix_name
  cluster_name = var.cluster_name
}


module "keypair" {
  source   = "../../modules/keypair"
  key_name = "my-ec2-keypair"
}


module "sg_alb" {
  source      = "../../modules/alb-sg"
  prefix_name = var.prefix_name
  prefix_env  = var.prefix_env
  vpc_id      = module.vpc.vpc_id
}

module "sg_wp" {
  source      = "../../modules/sg-wp"
  prefix_name = var.prefix_name
  prefix_env  = var.prefix_env
  vpc_id      = module.vpc.vpc_id
  alb_sg_id   = module.sg_alb.alb_sg_id
}

module "sg_db" {
  source      = "../../modules/sg-db"
  prefix_name = var.prefix_name
  prefix_env  = var.prefix_env
  vpc_id      = module.vpc.vpc_id
  wp_sg_id    = module.sg_wp.wp_sg_id
}
