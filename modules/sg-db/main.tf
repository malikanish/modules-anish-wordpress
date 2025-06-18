
resource "aws_security_group" "db_sg" {
  name        = "${var.prefix_name}-db-sg-${var.prefix_env}"
  description = "Allow MySQL only from WordPress SG"
  vpc_id      = var.vpc_id

  ingress {
    description     = "MySQL access from WordPress"
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [var.wp_sg_id] 
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.prefix_name}-db-sg-${var.prefix_env}"
  }
}