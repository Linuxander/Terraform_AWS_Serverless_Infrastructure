output "rds_subnet_group_id" {
  value     = var.rds_security_group_id_ref
  sensitive = false
}

output "rds_subnets" {
  value     = var.rds_subnets_ref
  sensitive = false
}

# output "terraform_aws_role_output" {
#   value = aws_iam_role.lambda_role.arn
# }

output "db_host" {
  value = var.db_host
}

output "lambda_create_user_arn" {
  value = aws_lambda_function.terraform_lambda_func.arn
}

output "lambda_create_user_function_name" {
  value = aws_lambda_function.terraform_lambda_func.function_name
}