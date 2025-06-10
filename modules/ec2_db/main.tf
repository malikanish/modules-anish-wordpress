resource "aws_instance" "db_instance" {
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = var.private_subnet_id
#   key_name      = var.key_name
   key_name               = aws_key_pair.my_key_pair.key_name



  security_groups = [var.security_group_id]

  user_data = filebase64("${path.module}/userdata_db.sh")

  tags = {
    Name = var.db_instance_name
  }
}

resource "aws_key_pair" "my_key_pair" {
  key_name   = "Ani-key"
  public_key = file(var.public_key_path)
}
