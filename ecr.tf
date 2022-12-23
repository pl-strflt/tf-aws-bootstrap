provider "aws" {
  alias  = "us_east_1"
  region = "us-east-1"
}

resource "aws_iam_user" "ecr-pl-strflt" {
  name = "ecr-pl-strflt"

  tags = local.tags
}

resource "aws_iam_user_policy" "ecr-pl-strflt" {
  name = "ecr-pl-strflt"
  user = "${aws_iam_user.ecr-pl-strflt.name}"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "ecr-public:GetAuthorizationToken",
          "ecr-public:BatchCheckLayerAvailability",
          "ecr-public:PutImage",
          "ecr-public:InitiateLayerUpload",
          "ecr-public:UploadLayerPart",
          "ecr-public:CompleteLayerUpload",
          "sts:GetServiceBearerToken"
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}

resource "aws_ecrpublic_repository" "registry" {
  provider = aws.us_east_1

  repository_name = "registry"

  catalog_data {
    about_text        = "[Unofficial image for the distribution](https://github.com/pl-strflt/distribution-library-image)"
    description       = "Unofficial image for the distribution."
  }
}

data "aws_caller_identity" "current" {}

resource "aws_ecrpublic_repository_policy" "registry" {
  repository_name = aws_ecrpublic_repository.registry.repository_name

  policy = jsonencode({
    Version = "2008-10-17"
    Statement = [
      {
        Sid    = "AllowPush"
        Effect = "Allow"
        Principal = {
          AWS = [
            "arn:aws:iam::${data.aws_caller_identity.current.account_id}:user/${aws_iam_user.ecr-pl-strflt.name}"
          ]
        }
        Action = [
          "ecr-public:BatchCheckLayerAvailability",
          "ecr-public:PutImage",
          "ecr-public:InitiateLayerUpload",
          "ecr-public:UploadLayerPart",
          "ecr-public:CompleteLayerUpload"
        ]
      }
    ]
  })
}
