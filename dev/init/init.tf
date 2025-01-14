terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.83.0"
    }
  }
}

provider "aws" {
   region = "${var.region}"
}

resource "aws_s3_bucket" "tfstate" {
   bucket = "${var.account_id}-${var.region}-tfstate"
}

resource "aws_s3_bucket_versioning" "versioning_tfstate" {
  bucket = aws_s3_bucket.tfstate.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_dynamodb_table" "terraform_state_lock" {
  name           = "terraform-lock"
  hash_key       = "LockID"
  billing_mode   = "PAY_PER_REQUEST"

  attribute {
    name = "LockID"
    type = "S"
  }
}

variable "region" {
   default = "ap-northeast-1"
}

variable "account_id" {
   default = "thessen"
}
