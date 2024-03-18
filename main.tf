terraform {
  backend "s3" {
    bucket = "panbucket1266002"
    key    = "tf-state"
    region = "us-east-1"
  }
}
