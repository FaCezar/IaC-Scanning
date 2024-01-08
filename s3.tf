# S3 Bucket Create

# Generate a random string for the S3 bucket name
resource "random_string" "bucket_suffix" {
  length  = 8
  special = false
  upper   = false
}

# Create an S3 bucket with a random name
resource "aws_s3_bucket" "pc-national-bank-bucket" {
  bucket = "pc-national-bank-bucket-${random_string.bucket_suffix.result}"
  tags = {
    yor_name  = "pc-national-bank-bucket"
    yor_trace = "11e618e3-6df3-4903-b612-8b5e3dc9428e"
  }
}

resource "aws_s3_object" "pc-national-bank-bucket-object" {
  for_each = fileset("${path.module}/s3_files", "*")
  bucket   = aws_s3_bucket.pc-national-bank-bucket.bucket
  key      = each.value
  source   = "${path.module}/s3_files/${each.value}"
  tags = {
    yor_name  = "pc-national-bank-bucket-object"
    yor_trace = "e84fb7ba-e7fe-43f3-ace1-fdf63a7392b5"
  }
}