variable "project_name" {
  description = "Variable used for setting the Name tag on resrouces."
  type        = string
}

variable "region" {
  description = "Variable for the AWS region."
  type        = string
}

# --- BEGINS: vpc_default variables ---
variable "vpc_default_cidr" {
  description = "This is the CIDR used for vpc_default resource"
  default     = "10.2.0.0/16"
}
# --- ENDS: vpc variables ---


variable "public_subnets" {
  description = "List of public subnet CIDRs"
  type        = list(string)
  default     = ["10.2.4.0/24", "10.2.5.0/24", "10.2.6.0/24"]
}