output "name" {
  value = data.aws_availability_zones.available.names
}

output "ami_id" {
  value = data.aws_ami.rhel9_devops.id
  
}

# output "alb_dns_name" {
#   value = aws_lb.app_alb.dns_name
  
# }

output "database_private-IP" {
  value = aws_instance.database.private_ip 
}

output "backend_private-IP" {
  value = aws_instance.backend.private_ip 
}

output "frontend_private-IP" {
  value = aws_instance.web.private_ip  
}

output "bastion_public-IP" {
  value = aws_instance.bastion.public_ip   
}

output "web_public-IP" {
  value = aws_instance.web.public_ip   
}
