terraform {
  required_version = "~>1.0.0"

  required_providers {
    aws = {
        source  = "hashicorp/aws"
        version = "~> 5.0"
    }
    random = {
        source  = "hashicorp/random"
        version = "~> 3.1"
    }
  }
}

provider "aws" {
  region = "ap-south-1"
  shared_config_files = ["C:/Users/nikhil/.aws/config"]
  shared_credentials_files = ["C:/Users/nikhil/.aws/credentials"]
}