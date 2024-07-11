resource "aws_api_gateway_rest_api" "api_gateway_lambda_create_post" {
  name        = "APIGatewayLambdaCreatePost"
  description = "The API Gatway for the Create Post Lambda function"
}

resource "aws_api_gateway_resource" "api_gateway_resource" {
  rest_api_id = aws_api_gateway_rest_api.api_gateway_lambda_create_post.id
  parent_id   = aws_api_gateway_rest_api.api_gateway_lambda_create_post.root_resource_id
  path_part   = "createPost" # This is the part of the URL path
}