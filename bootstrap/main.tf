terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.0"
    }
    random = {
      source  = "hashicorp/random"
      version = ">= 3.0"
    }
  }
}

resource "random_id" "suffix" {
  byte_length = 4
}

resource "aws_s3_bucket" "tf_state" {
  bucket        = "myterraformstatebuckets3-${random_id.suffix.hex}"
  force_destroy = true
  acl           = "private"
  region        = "us-east-1"

  tags = {
    Name = "Terraform State Bucket"
  }
}

resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.tf_state.id
  region = "us-east-1"

  versioning_configuration {
    status = "Enabled"
  }
}
