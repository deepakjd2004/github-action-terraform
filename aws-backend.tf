provider "aws" {
  region = var.aws_region
  # their is no need to specify access credentials as we are setting them as env variable in the shell
}

backend "s3" {
       bucket = "tf-backend-dj"
       key    = "state/terraform.tfstate"
       region = var.aws_region
   }
}
