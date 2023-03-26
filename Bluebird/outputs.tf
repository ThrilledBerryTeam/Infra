# output "vpc_id" {
#   value = aws_vpc.my-vpc
# }

output "public_dns" {
  description = "Public DNS"
  value       = try(aws_instance.docker.public_dns)
}

output "public_subnet" {
  description = "Public Subnet"
  value       = module.vpc.public_subnets
}
