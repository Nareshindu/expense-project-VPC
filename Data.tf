data "aws_availability_zones" "available" {
  state = "available"
}

# Get the AMI dynamically instead of hardcoding
data "aws_ami" "rhel9_devops" {
  most_recent = true

  filter {
    name   = "name"
    values = ["RHEL-9-DevOps-Practice"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["973714476881"] 
}


# Route53 Hosted Zone (already should exist for nareshtransportservices.online)
# If it already exists, import it or just reference it here:
# data "aws_route53_zone" "main" {
#   name         = "nareshtransportservices.online"
#   private_zone = false
# }