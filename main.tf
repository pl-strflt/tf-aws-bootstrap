terraform {
  backend "s3" {
    # account_id = "642361402189"
    region               = "us-east-1"
    bucket               = "tf-aws-bootstrap"
    key                  = "terraform.tfstate"
    dynamodb_table       = "tf-aws-bootstrap"
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }

  required_version = "~> 1.1.4"
}

locals {
  tags = {
    Name = "Terraform AWS Bootstrap"
    Url  = "https://github.com/pl-strflt/tf-aws-bootstrap"
  }
}

provider "aws" {}

data "aws_region" "default" {}
