terraform {
  backend "s3" {
    bucket  = "terrajenk"
    key     = "terraform.tfstate"
    region  = "us-east-1"
  }
}
