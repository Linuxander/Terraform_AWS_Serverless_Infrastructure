output "base_uapi_gateway_url_create_user" {
  value = aws_api_gateway_deployment.apigw_deployment.invoke_url
}