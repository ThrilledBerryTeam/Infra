terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = ">=4.54"
    }
  }
}

provider "aws" {
  # Configuration options
  region = var.region
  profile = "earlybeam" 
}
