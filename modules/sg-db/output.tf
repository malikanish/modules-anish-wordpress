# output "db_sg_id" {
#   description = "ID of the DB Security Group"
#   value       = aws_security_group.db_sg.id
# }


output "db_sg_id" {
  value = aws_security_group.db_sg.id
}
