terraform {
  backend "s3" {
    profile = "[name of your profile goes here]"
    bucket  = "[name of your S3 bucket here]"
    key     = "[path to your terraform.tfstate in the bucket name you provided]"
    region  = "us-east-1"
  }
}
