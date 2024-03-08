terraform {
  backend "s3" {
    bucket = "${var.tfstate}"
    key    = "tf-state"
    region = "us-east-1"
  }
}
