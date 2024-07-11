resource "aws_api_gateway_authorizer" "cognito_user_pool_authorizer" {
  name            = "CognitoUserPoolAuthorizer"
  rest_api_id     = aws_api_gateway_rest_api.api_gateway_lambda_create_user.id
  identity_source = "method.request.header.Authorization"
  provider_arns   = [var.cognito_user_pool_arn]
  type            = "COGNITO_USER_POOLS"
}