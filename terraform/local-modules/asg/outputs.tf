# ASG / LC
output "asg_id" {
  description = "The autoscaling group id"
  value       = module.this_asg.this_autoscaling_group_id
}

output "asg_name" {
  description = "The autoscaling group name"
  value       = module.this_asg.this_autoscaling_group_name
}

output "asg_arn" {
  description = "The ARN for this AutoScaling Group"
  value       = module.this_asg.this_autoscaling_group_arn
}

output "asg_min_size" {
  description = "The minimum size of the autoscale group"
  value       = module.this_asg.this_autoscaling_group_min_size
}

output "asg_max_size" {
  description = "The maximum size of the autoscale group"
  value       = module.this_asg.this_autoscaling_group_max_size
}

output "asg_desired_capacity" {
  description = "The number of Amazon EC2 instances that should be running in the group"
  value       = module.this_asg.this_autoscaling_group_desired_capacity
}

output "asg_availability_zones" {
  description = "The availability zones of the autoscale group"
  value       = module.this_asg.this_autoscaling_group_availability_zones
}

output "asg_security_group_id" {
  description = "The security group of instances in the autoscale group"
  value       = module.this_sg.this_security_group_id
}

output "instance_user_data" {
  description = "The user data script used to boot strap instances"
  value       = var.instance_user_data
}
