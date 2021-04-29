provider "aws" {
  region = "us-east-1"
}

terraform {
  backend "s3" {
    bucket         = "onweek-test-tf-state"
    key            = "onweek-test"
    region         = "us-east-1"
    dynamodb_table = "tf-state"
  }
}