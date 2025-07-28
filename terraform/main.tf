# A bucket to store access logs, which also needs to be secure.
resource "aws_s3_bucket" "log_bucket" {
  bucket = "my-secure-devsecops-log-bucket-12345"

  # Enable versioning for the log bucket as well
  versioning {
    enabled = true
  }

  # Enable encryption for the log bucket
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

# Add a public access block for the log bucket
resource "aws_s3_bucket_public_access_block" "log_bucket_pab" {
  bucket = aws_s3_bucket.log_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}


# The main, fully secured S3 bucket
resource "aws_s3_bucket" "secure_bucket" {
  bucket = "my-secure-devsecops-bucket-12345"

  versioning {
    enabled = true
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  # Enable access logging, pointing to the now-secure log bucket
  logging {
    target_bucket = aws_s3_bucket.log_bucket.id
    target_prefix = "log/"
  }
}

# Define the public access block for the main bucket
resource "aws_s3_bucket_public_access_block" "secure_bucket_pab" {
  bucket = aws_s3_bucket.secure_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}