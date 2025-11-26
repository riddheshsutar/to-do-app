terraform {
  required_version = ">= 1.6.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    random = {
      source  = "hashicorp/random"
      version = ">= 3.6.0"
    }
  }
}

provider "aws" {
  region = var.region
}


# Random suffix to avoid bucket name clashes
resource "random_id" "suffix" {
  byte_length = 3
}

locals {
  bucket_name = "${var.name_prefix}-tfstate-${random_id.suffix.hex}"
}

# ---- S3 bucket for remote state ----
resource "aws_s3_bucket" "tfstate" {
  bucket        = local.bucket_name
  force_destroy = true
}

resource "aws_s3_bucket_versioning" "tfstate" {
  bucket = aws_s3_bucket.tfstate.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "tfstate" {
  bucket = aws_s3_bucket.tfstate.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# ---- DynamoDB table for state locking ----
resource "aws_dynamodb_table" "lock" {
  name         = "${var.name_prefix}-tf-lock"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}

# ---- Outputs ----
# output "bucket_name" {
#   value = aws_s3_bucket.tfstate.bucket
# }

# output "lock_table" {
#   value = aws_dynamodb_table.lock.name
# }

# output "region" {
#   value = var.region
# }
