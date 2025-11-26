output "bucket_name" {
  value = aws_s3_bucket.tfstate.bucket
}

output "lock_table" {
  value = aws_dynamodb_table.lock.name
}

output "region" {
  value = var.region
}
