# ELB
output "app_elb_dns_name" {
  description = "The DNS name of the app ELB"
  value       = module.app.elb_dns_name
}
