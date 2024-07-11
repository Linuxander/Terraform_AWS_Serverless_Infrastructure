variable "region" {
  default     = "us-east-1"
  description = "AWS region"
}

variable "db_host" {
  description = "DB host defined in the database/rds module"
  default     = ""
}

variable "rds_security_group_id_ref" {
  description = "A reference to the rds subnet group ID"
  default     = ""
}

variable "rds_subnets_ref" {
  description = "A reference to the rds subnets"
  default     = ""
}

variable "layer_arn_mysqlconnector" {
  description = "The ARN of the mysqlconnector layer"
}