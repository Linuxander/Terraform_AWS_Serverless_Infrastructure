resource "aws_lambda_layer_version" "mysqlconnector_layer" {
  filename   = "${path.module}/layers/mysqlconnector_layer.zip"
  layer_name = "mysqlconnector_layer"

  compatible_runtimes = ["python3.10"] # Adjust according to your Lambda's Python runtime

  source_code_hash = filebase64sha256("${path.module}/layers/mysqlconnector_layer.zip")
}