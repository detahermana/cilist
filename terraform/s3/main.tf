terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "4.9.0"
    }
  }
}

provider "aws" {
  access_key = ""
  secret_key = ""
  region = ""
}

resource "aws_s3_bucket" "cilist_state" {
  bucket = "cilist-state"
  acl = "private"
  
  versioning {
    enabled = true
  }

  tags = {
    Name = "cilist-state"
  }
}