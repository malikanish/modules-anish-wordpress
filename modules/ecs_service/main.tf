resource "aws_ecs_task_definition" "wordpress" {
  family                   = "wordpress-task"
  requires_compatibilities = ["EC2"]
  network_mode             = "bridge"
  cpu                      = "300"
  memory                   = "300"

  container_definitions = jsonencode([
    {
      name      = "wordpress"
      image     = "wordpress:latest"
      essential = true
      portMappings = [{
        containerPort = 80
        hostPort      = 80
      }]
      environment = [
        { name = "WORDPRESS_DB_HOST", value = var.db_host },
        { name = "WORDPRESS_DB_NAME", value = "wordpress" },
        { name = "WORDPRESS_DB_USER", value = "wpuser" },
        { name = "WORDPRESS_DB_PASSWORD", value = "password" }
      ]
    }
  ])
}



resource "aws_ecs_service" "wordpress" {
  name            = "wordpress-service"
  cluster         = var.cluster_id
  launch_type     = "EC2"
  desired_count   = 1
  task_definition = aws_ecs_task_definition.wordpress.arn

  load_balancer {
    target_group_arn = var.target_group_arn  
    container_name   = "wordpress"
    container_port   = 80
  }

}
