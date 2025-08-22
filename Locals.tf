locals {
  resource_name = "${var.vpc_name}-${var.env}"
  az_names = slice(data.aws_availability_zones.available.names, 0, 2)  
}