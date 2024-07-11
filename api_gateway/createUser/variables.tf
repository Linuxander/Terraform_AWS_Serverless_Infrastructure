variable "region" {
  default     = "us-east-1"
  description = "AWS region"
}

variable "lambda_invoke_arn" {
  description = "The invoke ARN for the lambda function associated with this API Gateway module. (i.e. aws_lambda_function.example.invoke_arn)"
  type        = string
}

variable "lambda_function_name" {
  description = "The lambda function name associated with this API Gateway module.  Provide the value from lambda module."
  type        = string
}

variable "stage" {
  description = "Specify the stage this api gateway should accept calls from (i.e. test, dev, prod"
  type        = string
}

variable "method_type" {
  description = "Define the method type here"
  type        = string
}

variable "path_part" {
  type = string
}

variable "cognito_user_pool_arn" {
  description = "Variable to hold the cognito user pool arn.  Ensure to pass the value of this variable from the cognito module."
  type        = string
}