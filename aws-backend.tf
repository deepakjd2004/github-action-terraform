provider "aws" {
  region = var.aws_region
  # their is no need to specify access credentials as we are setting them as env variable in the shell
}
