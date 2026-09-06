terraform {
  backend "s3" {
    bucket  = "terraform-remote-state-30days-bucket"
    key     = "day-03/terraform.tfstate"
    region  = "ap-south-1"
    encrypt = true
    # lock_table = "terraform-remote-state-30days-lock"    # uses for DynamoDB table to lock the state file, but it is optional
    use_lockfile = true
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.1"
    }
  }
}

provider "aws" {
  region                   = var.aws_region
  shared_config_files      = [var.config]
  shared_credentials_files = [var.creds]
}

variable "config" {
  type        = string
  description = "user_config_file"
  sensitive   = true
}

variable "creds" {
  type        = string
  description = "user_creds_file"
  sensitive   = true
}

variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
}