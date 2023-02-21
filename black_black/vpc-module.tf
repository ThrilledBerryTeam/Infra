module "vpc" {
  source           = "terraform-aws-modules/vpc/aws"
  instance_tenancy = "default"
  name             = var.vpc_name
  cidr             = "10.0.0.0/16"
  create_igw       = true

  #   default_security_group_egress =
  #   default_security_group_ingress =
  #   default_security_group_name =
  #   default_security_group_tags =

  azs             = ["us-east-1a"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

  enable_nat_gateway = true
  enable_vpn_gateway = false

  tags = {
    Name        = var.vpc_name
    Company     = var.company_name
    Project     = var.project_name
    Environment = var.environment
  }
}