resource "aws_cognito_user_pool_client" "user_pool_client" {
  name                          = var.user_pool_name
  user_pool_id                  = aws_cognito_user_pool.user_pool.id
  supported_identity_providers  = ["COGNITO"]
  explicit_auth_flows           = ["ALLOW_USER_SRP_AUTH", "ALLOW_REFRESH_TOKEN_AUTH", "ALLOW_USER_PASSWORD_AUTH"]
  generate_secret               = false
  prevent_user_existence_errors = "LEGACY"
  refresh_token_validity        = 1
  access_token_validity         = 1
  id_token_validity             = 1
  token_validity_units {
    access_token  = "hours"
    id_token      = "hours"
    refresh_token = "hours"
  }
}