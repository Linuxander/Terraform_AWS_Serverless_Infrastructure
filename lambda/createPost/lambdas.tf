resource "aws_lambda_function" "terraform_lambda_func" {
  vpc_config {
    subnet_ids         = [for s in var.rds_subnets_ref : s.id]
    security_group_ids = [var.rds_security_group_id_ref]
  }

  environment {
    variables = {
      DB_HOST     = var.db_host
      DB_USERNAME = data.aws_ssm_parameter.db_user.value
      DB_PASSWORD = data.aws_ssm_parameter.db_user_pw.value
      DB_NAME     = data.aws_ssm_parameter.db_name.value
    }
  }

  filename      = "${path.module}/python/createPost.zip"
  function_name = "create_post_function"
  role          = aws_iam_role.lambda_role.arn
  handler       = "create_post.lambda_handler" # has to match the name of python file
  runtime       = "python3.10"
  timeout       = 10
  depends_on    = [aws_iam_role_policy_attachment.attach_iam_policy_to_iam_role]
  layers        = [var.layer_arn_mysqlconnector]
}