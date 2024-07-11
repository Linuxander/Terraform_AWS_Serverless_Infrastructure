output "db_host" {
  value = aws_db_instance.rds_instance_default.endpoint
}