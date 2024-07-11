variable "region" {
  description = "The region to deploy these cognito resources to"
  type        = string
}

variable "user_pool_name" {
  description = "Name of user pool"
  type        = string
  default     = "my-user-pool"
}

variable "identity_pool_name" {
  description = "Name of identity pool"
  type        = string
  default     = "my-identity-pool"
}