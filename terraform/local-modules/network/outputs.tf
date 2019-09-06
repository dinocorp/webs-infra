# VPC
output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.this_vpc.vpc_id
}

# Subnets
output "private_subnets" {
  description = "List of IDs of private subnets"
  value       = module.this_vpc.private_subnets
}

output "public_subnets" {
  description = "List of IDs of public subnets"
  value       = module.this_vpc.public_subnets
}

# NAT gateways
output "nat_public_ips" {
  description = "List of public Elastic IPs created for AWS NAT Gateway"
  value       = module.this_vpc.nat_public_ips
}

# Security group
output "default_security_group_id" {
  description = "Default security group ID"
  value       = module.this_sg.this_security_group_id
}
