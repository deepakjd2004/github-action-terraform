terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
    akamai = {
      source  = "akamai/akamai"
      version = "1.9.0"
    }
  }
  backend "s3" {
    bucket = "<>"
    key    = "state/terraform.tfstate"
    region = "<>"
  }
}
