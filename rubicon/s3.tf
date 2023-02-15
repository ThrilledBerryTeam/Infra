terraform {
  backend "s3" { 
    bucket = "rubicon-bucket"
    key = "rubicon-website-infra.tfstate"
    region = "us-east-1"
    profile = "default"
  }
}
