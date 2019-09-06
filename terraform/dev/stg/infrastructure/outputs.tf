output "environment" {
  description = "The current environment"
  value       = var.environment
}

# VPC
output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.network.vpc_id
}

output "vpc_subnet" {
  description = "The subnet of the VPC"
  value       = var.vpc_subnet
}

# Subnets
output "private_subnets" {
  description = "List of IDs of private subnets"
  value       = var.private_subnets
}

output "public_subnets" {
  description = "List of IDs of public subnets"
  value       = var.public_subnets
}

output "private_subnet_ids" {
  description = "List of IDs of private subnets"
  value       = module.network.private_subnets
}

output "public_subnet_ids" {
  description = "List of IDs of public subnets"
  value       = module.network.public_subnets
}

# NAT gateways
output "nat_public_ips" {
  description = "List of public Elastic IPs created for AWS NAT Gateway"
  value       = module.network.nat_public_ips
}

# Security groups
output "default_security_group_id" {
  description = "Default security group ID"
  value       = module.network.default_security_group_id
}
