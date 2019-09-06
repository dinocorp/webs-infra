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

output "asg_load_balancers" {
  description = "The load balancer names associated with the autoscaling group"
  value       = module.this_asg.this_autoscaling_group_load_balancers
}

output "instance_user_data" {
  description = "The user data script used to boot strap instances"
  value       = var.instance_user_data
}

# ELB
output "elb_id" {
  description = "The name of the ELB"
  value       = module.this_elb.this_elb_id
}

output "elb_arn" {
  description = "The ARN of the ELB"
  value       = module.this_elb.this_elb_arn
}

output "elb_name" {
  description = "The name of the ELB"
  value       = module.this_elb.this_elb_name
}

output "elb_dns_name" {
  description = "The DNS name of the ELB"
  value       = module.this_elb.this_elb_dns_name
}

output "elb_instances" {
  description = "The list of instances in the ELB"
  value       = module.this_elb.this_elb_instances
}

output "elb_zone_id" {
  description = "The canonical hosted zone ID of the ELB (to be used in a Route 53 Alias record)"
  value       = module.this_elb.this_elb_zone_id
}

output "elb_security_group_id" {
  description = "The ID of the ELB security group"
  value       = module.this_elb_sg.this_security_group_id
}

output "instance_security_group_id" {
  description = "The ID of the ASG (instances) security group"
  value       = module.this_instance_sg.this_security_group_id
}
