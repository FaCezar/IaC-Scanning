terraform {
  backend "s3" {
    bucket = "panbucket1260105"
    key    = "tf-state"
    region = "us-east-1"
  }
}
