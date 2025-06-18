
resource "aws_ecs_cluster" "this" {
  name = var.cluster_name
}

resource "aws_iam_role" "ecs_instance_role" {
  name = "${var.prefix_name}-ecs-instance-roles"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "ecs_instance_attach" {
  role       = aws_iam_role.ecs_instance_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
}

# 3. Instance Profile
resource "aws_iam_instance_profile" "ecs_instance_profile" {
  name = "${var.prefix_name}-ecs-instance-profile"
  role = aws_iam_role.ecs_instance_role.name
}
