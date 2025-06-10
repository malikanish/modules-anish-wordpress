
output "vpc_id" {
  value = aws_vpc.anish_vpc.id
}

output "public_subnet_ids" {
  value = aws_subnet.public_subnets[*].id
}

output "private_subnet_ids" {
  value = aws_subnet.private_subnets[*].id
}

output "public_subnet_id_1" {
  description = "First public subnet"
  value       = aws_subnet.public_subnets[0].id
}

output "public_subnet_id_2" {
  description = "Second public subnet"
  value       = aws_subnet.public_subnets[1].id
}
