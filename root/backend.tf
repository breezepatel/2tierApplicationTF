terraform {
  backend "s3" {
    bucket         = "tfstate-breeze-2tier-application"
    key            = "backend/terraform.tfstate"
    region         = "ca-central-1"
    dynamodb_table = "remote-backend"
  }
}