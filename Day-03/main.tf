# Create S3 bucket
resource "aws_s3_bucket" "ninox_bucket" {
  bucket           = "ninox-bucket-tf"
  bucket_namespace = "global"

  tags = {
    Name        = "Ninox Bucket"
    Environment = "Dev"
  }
}


resource "aws_s3_bucket_public_access_block" "public_access_block" {
  bucket = aws_s3_bucket.ninox_bucket.id

  block_public_acls       = false
  block_public_policy     = true
  ignore_public_acls      = false
  restrict_public_buckets = true
}

resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.ninox_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}


  