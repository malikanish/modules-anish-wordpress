output "db_instance_private_ip" {
  value = aws_instance.db_instance.private_ip
}

output "key_name" {
  value = aws_key_pair.my_key_pair.key_name
}
