terraform {
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
  region = var.aws_region
  shared_config_files = [var.config]
  shared_credentials_files = [var.creds]
}