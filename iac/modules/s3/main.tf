provider "aws" {
  region = "us-east-2"
}

resource "aws_s3_bucket" "carsdatascraperapidash1" {
  bucket = "carsdatascraperapidash1"
}

resource "aws_s3_bucket_acl" "carsdatascraperapidash1" {
  bucket = aws_s3_bucket.carsdatascraperapidash1.id
  acl = "private"
}

resource "aws_s3_bucket_server_side_encryption_configuration" "carsdatascraperapidash1_bucket_sse" {
  bucket = aws_s3_bucket.carsdatascraperapidash1.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_versioning" "carsdatascraperapidash1_bucket_versioning" {
  bucket = aws_s3_bucket.carsdatascraperapidash1.id
  versioning_configuration {
    status = "Enabled"
  }
}