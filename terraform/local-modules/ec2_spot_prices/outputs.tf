locals {
  this_spot_price = lookup(var.spot_prices, var.instance_type, "")
}

output "price" {
  description = "The max price for a spot instance type"
  value       = local.this_spot_price
}
