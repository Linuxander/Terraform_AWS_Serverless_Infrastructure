resource "aws_cognito_identity_pool" "identity_pool" {
  identity_pool_name               = var.identity_pool_name
  allow_unauthenticated_identities = false # Set to false to disallow unauthenticated access

  cognito_identity_providers {
    client_id               = aws_cognito_user_pool_client.user_pool_client.id
    provider_name           = "cognito-idp.${var.region}.amazonaws.com/${aws_cognito_user_pool.user_pool.id}"
    server_side_token_check = true
  }
}