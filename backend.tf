terraform {
  backend "s3" {
    bucket = "config-bucket-589717335779"
    key    = "demo"
    region = "us-east-1"
  }
}
