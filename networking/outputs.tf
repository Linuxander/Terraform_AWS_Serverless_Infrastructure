output "security_group_rds_id" {
  description = "The ID of the RDS security group"
  value       = aws_security_group.security_group_rds.id
}

output "subnet_group_rds_name" {
  description = "The name of the subnet_group_rds"
  value       = aws_db_subnet_group.subnet_group_rds.name
}

# output the aws_subnet.public_subnet_rds for lambda to filter through
output "rds_subnets" {
  description = "The rds subnets"
  value       = aws_subnet.subnet_default
}
