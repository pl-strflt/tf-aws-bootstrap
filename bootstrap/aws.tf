# terraform init
# export AWS_ACCESS_KEY_ID=
# export AWS_SECRET_ACCESS_KEY=
# terraform apply

terraform {
  required_providers {
    aws = {
      version = "4.5.0"
    }
  }

  required_version = "~> 1.1.4"
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "this" {
  bucket = "tf-aws-bootstrap"

  tags = {
    Name = "Terraform AWS Bootstrap"
    Url  = "https://github.com/pl-strflt/tf-aws-bootstrap"
  }
}

resource "aws_s3_bucket_acl" "this" {
  bucket = aws_s3_bucket.this.id
  acl    = "private"
}

resource "aws_dynamodb_table" "this" {
  name         = "tf-aws-bootstrap"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name = "Terraform AWS Bootstrap"
    Url  = "https://github.com/pl-strflt/tf-aws-bootstrap"
  }
}
