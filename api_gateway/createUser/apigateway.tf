resource "aws_api_gateway_rest_api" "api_gateway_lambda_create_user" {
  name        = "APIGatewayLambdaCreateUser"
  description = "The API Gatway for the Create User Lambda function"
}

resource "aws_api_gateway_resource" "api_gateway_resource" {
  rest_api_id = aws_api_gateway_rest_api.api_gateway_lambda_create_user.id
  parent_id   = aws_api_gateway_rest_api.api_gateway_lambda_create_user.root_resource_id
  path_part   = "createUser" # This is the part of the URL path
}