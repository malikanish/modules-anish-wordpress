output "aws_vpc_id" {
  value = module.vpc.vpc_id
}


output "private_key_pem" {
  value     = module.keypair.private_key_pem
  sensitive = true
}

output "key_name" {
  value = module.keypair.key_name
}
