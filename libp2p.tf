resource "aws_s3_bucket" "libp2p" {
  bucket = "libp2p-by-tf-aws-bootstrap"

  tags = {
    Name = "aws_s3_bucket.libp2p"
    Url  = "https://github.com/pl-strflt/tf-aws-bootstrap"
  }
}

resource "aws_s3_bucket_policy" "libp2p" {
  bucket = aws_s3_bucket.libp2p.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "s3:GetObject",
          "s3:GetObjectAcl",
          # "s3:PutObject",
          # "s3:PutObjectAcl",
          # "s3:DeleteObject",
          "s3:ListMultipartUploadParts",
          # "s3:AbortMultipartUpload"
        ]
        Effect   = "Allow"
        Resource = ["${aws_s3_bucket.libp2p.arn}/*"]
        Principal = "*"
      },
      {
        Action = [
          "s3:ListBucket",
          "s3:GetBucketLocation",
          "s3:ListBucketMultipartUploads"
        ]
        Effect   = "Allow"
        Resource = [aws_s3_bucket.libp2p.arn]
        Principal = "*"
      }
    ]
  })
}

resource "aws_s3_bucket_lifecycle_configuration" "libp2p" {
  bucket = aws_s3_bucket.libp2p.id

  rule {
    id = "default"
    filter {
      prefix = ""
    }
    expiration {
      days = 90
    }
    status = "Enabled"
  }
}

resource "aws_iam_user" "libp2p" {
  name = "libp2p"

  tags = {
    Name = "aws_iam_user.libp2p"
    Url  = "https://github.com/pl-strflt/tf-aws-bootstrap"
  }
}

resource "aws_iam_user_policy" "libp2p" {
  name = "libp2p"
  user = aws_iam_user.libp2p.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "s3:GetObject",
          "s3:GetObjectAcl",
          "s3:PutObject",
          "s3:PutObjectAcl",
          "s3:DeleteObject",
          "s3:ListMultipartUploadParts",
          "s3:AbortMultipartUpload"
        ]
        Effect   = "Allow"
        Resource = ["${aws_s3_bucket.libp2p.arn}/*"]
      },
      {
        Action = [
          "s3:ListBucket",
          "s3:GetBucketLocation",
          "s3:ListBucketMultipartUploads"
        ]
        Effect   = "Allow"
        Resource = [aws_s3_bucket.libp2p.arn]
      }
    ]
  })
}

resource "aws_iam_user" "libp2p-read-only" {
  name = "libp2p-read-only"

  tags = {
    Name = "aws_iam_user.libp2p-read-only"
    Url  = "https://github.com/pl-strflt/tf-aws-bootstrap"
  }
}

resource "aws_iam_user_policy" "libp2p-read-only" {
  name = "libp2p-read-only"
  user = aws_iam_user.libp2p-read-only.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "s3:GetObject",
          "s3:GetObjectAcl",
          # "s3:PutObject",
          # "s3:PutObjectAcl",
          # "s3:DeleteObject",
          "s3:ListMultipartUploadParts",
          # "s3:AbortMultipartUpload"
        ]
        Effect   = "Allow"
        Resource = ["${aws_s3_bucket.libp2p.arn}/*"]
      },
      {
        Action = [
          "s3:ListBucket",
          "s3:GetBucketLocation",
          "s3:ListBucketMultipartUploads"
        ]
        Effect   = "Allow"
        Resource = [aws_s3_bucket.libp2p.arn]
      }
    ]
  })
}
