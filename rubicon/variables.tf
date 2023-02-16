variable "instance_type" {
  description = "The type of instance to start"
  type        = string
  default     = "t2.micro"
}

# variable "vpc_security_group_ids" {
#   description = "A list of security group IDs to associate with"
#   type        = list(string)
#   default     = null
# }

# variable "subnet_id" {
#   description = "The VPC Subnet ID to launch in"
#   type        = string
#   default     = null
# }


