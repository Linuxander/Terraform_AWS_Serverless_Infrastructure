resource "aws_api_gateway_deployment" "apigw_deployment" {
  depends_on = [
    aws_api_gateway_integration.lambda_integration,
    aws_api_gateway_integration.lambda_root,
  ]

  rest_api_id = aws_api_gateway_rest_api.api_gateway_lambda_create_user.id
  stage_name  = var.stage

  triggers = {
    redeployment = sha256(join(",", [
      jsonencode(aws_api_gateway_method.proxy),
      jsonencode(aws_api_gateway_authorizer.cognito_user_pool_authorizer)
    ]))
  }

  lifecycle {
    create_before_destroy = true
  }
}