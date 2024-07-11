data "aws_ssm_parameter" "db_name" {
  name = "[aws parameter store path to your db_name key]"
}

data "aws_ssm_parameter" "db_user" {
  name = "[aws parameter store path to your db_user_name key]"
}

data "aws_ssm_parameter" "db_user_pw" {
  name = "[aws parameter store path to your db_user_cred key]"
}

data "archive_file" "zip_createPost_code" {
  type        = "zip"
  source_dir  = "${path.module}/python/"
  output_path = "${path.module}/python/createUser.zip"
}