terraform {
  required_version = ">= 1.9.6"

  backend "s3" {
    bucket         = "thessen-apnortheast1-tfstate"
    key            = "terraform-test/dev/vpc/rurud_apnortheast1/transitgw/terraform.tfstate"
    region         = "ap-northeast-1"
    encrypt        = true
    dynamodb_table = "terraform-lock"
  }
}
