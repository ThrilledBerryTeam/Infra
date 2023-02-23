g//This Terraform Template creates a Docker machine on EC2 Instance.
//Docker Machine will run on Amazon Linux 2 (ami-026dea5602e368e96) EC2 Instance with
//custom security group allowing SSH connections from anywhere on port 22.

resource "aws_instance" "docker" {
  ami                    = data.aws_ami.amazon-linux-2.id
  instance_type          = var.instance_type
  key_name               = var.pem_file
  vpc_security_group_ids = [aws_security_group.docker.id]
  subnet_id              = module.vpc.public_subnets[0]
  user_data              = file("userdata.sh")
  tags = {
    Name = "${var.company_name}-docker-instance"
  }
}

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