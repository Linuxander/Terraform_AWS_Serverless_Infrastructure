resource "aws_api_gateway_resource" "proxy" {
  rest_api_id = aws_api_gateway_rest_api.api_gateway_lambda_create_user.id
  parent_id   = aws_api_gateway_rest_api.api_gateway_lambda_create_user.root_resource_id
  path_part   = "{proxy+}"
}

resource "aws_api_gateway_method" "proxy" {
  rest_api_id   = aws_api_gateway_rest_api.api_gateway_lambda_create_user.id
  resource_id   = aws_api_gateway_resource.proxy.id
  http_method   = var.method_type
  authorization = "COGNITO_USER_POOLS"
  authorizer_id = aws_api_gateway_authorizer.cognito_user_pool_authorizer.id
  depends_on = [ aws_api_gateway_authorizer.cognito_user_pool_authorizer ]
}

resource "aws_api_gateway_method" "proxy_root" {
  rest_api_id   = aws_api_gateway_rest_api.api_gateway_lambda_create_user.id
  resource_id   = aws_api_gateway_resource.api_gateway_resource.id
  http_method   = var.method_type
  authorization = "COGNITO_USER_POOLS"
  authorizer_id = aws_api_gateway_authorizer.cognito_user_pool_authorizer.id
  depends_on = [ aws_api_gateway_authorizer.cognito_user_pool_authorizer ]
}