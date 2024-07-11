output "db_host" {
  value     = module.lambda_createUser.db_host
  sensitive = false
}

output "api_gateway_lambda_create_user_url" {
  value = module.apigw_createUser.base_uapi_gateway_url_create_user
}

output "api_gateway_lambda_create_post_url" {
  value = module.apigw_createPost.base_uapi_gateway_url_create_post
}

output "cognito_user_pool_id" {
  value = module.cognito.cognito_user_pool_id
}

output "cognito_user_pool_client_id" {
  value = module.cognito.cognito_user_pool_client_id
}

output "cognito_identity_pool_id" {
  value = module.cognito.cognito_identity_pool_id
}

# output "rds_subnet_group_id" {
#   value     = module.networking.security_group_rds_id
#   sensitive = false
# }

# output "rds_subnets" {
#   value     = module.networking.rds_subnets
#   sensitive = false
# }
