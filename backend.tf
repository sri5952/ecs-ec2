terraform {
  backend "s3" {
    bucket = "rdscur"
    key    = "demo"
    region = "us-east-1"
  }
}
