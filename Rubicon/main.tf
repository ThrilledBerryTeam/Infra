//This Terraform Template creates a Docker machine on EC2 Instance.
//Docker Machine will run on Amazon Linux 2 (ami-026dea5602e368e96) EC2 Instance with
//custom security group allowing SSH connections from anywhere on port 22.

terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~>4.0"
    }
  }
}

provider "aws" {
  # Configuration options
  region = "us-east-1"
  profile = "alper" 
}

# locals {
#   user = "alper"
#   pem_file = "rubicon_alper" # change your pem key here !!!
# }

################################################################################
# AWS_INSTANCE
################################################################################

resource "aws_instance" "tf_template" {
  ami = data.aws_ami.amazon-linux-2.id
  instance_type = var.instance_type
  key_name = local.pem_file
  vpc_security_group_ids = [aws_security_group.sample_tf.id]
  # vpc_security_group_ids = var.vpc_security_group_ids
  subnet_id = aws_subnet.my_subnet.id
  # subnet_id = var.subnet_id
  user_data = file("userdata.sh")
  tags = {
    Name = "${local.user}-docker-instance"
  }
}

################################################################################
# AWS_SECURITY_GROUP
################################################################################
resource "aws_security_group" "sample_tf" {
  name        = "ssh-http-https"
  description = "Allow SSH-HTTP-HTTPS for inbound traffic"
  vpc_id      = aws_vpc.main.id

  ingress {
    description      = "HTTPS from VPC"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    description      = "HTTP from VPC"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    description      = "SSH from VPC"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_ssh-http-https"
  }
}

################################################################################
# VPC
################################################################################
resource "aws_vpc" "main" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "template"
  }
}

################################################################################
# AWS_SUBNET
################################################################################
resource "aws_subnet" "my_subnet" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.10.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "tf-template"
  }
}

################################################################################
# DATA BLOCK AWS_AMI
################################################################################
data "aws_ami" "amazon-linux-2" {
  owners      = ["amazon"]
  most_recent = true

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "owner-alias"
    values = ["amazon"]
  }

  filter {
    name   = "name"
    values = ["amzn2-ami-kernel-5.10-hvm*"]
  }
}