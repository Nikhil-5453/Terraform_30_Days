variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
}

variable "creds" {
  type        = string
  description = "user_creds_file"
  sensitive   = true
}

variable "config" {
  type        = string
  description = "user_config_file"
}