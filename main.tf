terraform {
  backend "s3" {
    bucket = "panbucket1255085"
    key    = "tf-state"
    region = "us-east-1"
  }
}
