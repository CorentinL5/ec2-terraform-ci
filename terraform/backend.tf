terraform {
  backend "s3" {
    bucket = "myterraformstatebuckets3"
    key    = "terraform/terraform.tfstate"
    region = "us-east-1"
  }
}
