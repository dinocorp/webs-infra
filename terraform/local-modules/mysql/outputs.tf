# DB / RDS
output "db_cluster_endpoint" {
  description = "The cluster endpoint"
  value       = module.this_db.this_rds_cluster_endpoint
}

output "db_cluster_reader_endpoint" {
  description = "The cluster reader endpoint"
  value       = module.this_db.this_rds_cluster_reader_endpoint
}

output "db_cluster_master_password" {
  description = "The master password"
  value       = module.this_db.this_rds_cluster_master_password
}

output "db_cluster_port" {
  description = "The port"
  value       = module.this_db.this_rds_cluster_port
}

output "db_cluster_master_username" {
  description = "The master username"
  value       = module.this_db.this_rds_cluster_master_username
}

# Security group
output "db_security_group_id" {
  description = "DB security group ID"
  value       = module.this_sg.this_security_group_id
}
