variable "project_name" {
  description = "Variable used for setting the Name tag on resrouces."
  type        = string
}

variable "region" {
  default     = "us-east-1"
  description = "AWS region"
}

variable "target_subnet_group_name" {
  description = "The reference to the subnet group the RDS is supposed to use."
  type        = string
}

variable "target_security_group_id" {
  description = "The security group ID generated and provided by the networking module."
  type        = string
}