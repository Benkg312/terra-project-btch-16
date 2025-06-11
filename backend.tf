# backend.tf  ── purely configuration, NOT a resource
terraform {
  backend "s3" {
    bucket  = "tfstate-benkg312-us-east-1" # must exist first
    key     = "prod/terraform.tfstate"     # folder-like prefix
    region  = "us-east-1"
    encrypt = true # SSE-S3 encryption
  }
}
