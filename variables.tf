# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0
variable "project_name" {
  default = "[ENTER YOUR PROJECT NAME SO THAT YOUR CLOUD RESOURCES ARE TAGGED WITH IT]"
}

variable "region" {
  default     = "us-east-1"
  description = "AWS region"
}