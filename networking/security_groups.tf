resource "aws_security_group" "security_group_rds" {
  name        = "rds-sg"
  description = "Security group for RDS"
  vpc_id      = aws_vpc.vpc_default.id

  dynamic "ingress" {
    for_each = local.allowed_ips
    content {
      from_port   = 3306
      to_port     = 3306
      protocol    = "tcp"
      cidr_blocks = [ingress.value]
      description = "Allowed IP addresses"
    }
  }

  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.security_group_lambda.id]
    self            = true
    description     = "Allow access from lambdas security group"
  }

  egress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.security_group_lambda.id]
    self            = true
    description     = "Allow access from lambdas security group"
  }

  egress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project_name} - security group - rds"
  }
}


resource "aws_security_group" "security_group_lambda" {
  name        = "lambda-sg"
  description = "Security group for Lambda function to access RDS"
  vpc_id      = aws_vpc.vpc_default.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project_name} - security group - lambda"
  }
}