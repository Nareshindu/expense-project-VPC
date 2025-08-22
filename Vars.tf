variable "vpc_name" {
  default = "Student-project"
}

variable "vpc_cidr_block" {
  default = "10.0.0.0/16"
}


variable "env" {
    default = "prod"
}

variable "public_subnet_cidrs" {
    type = list
    default = ["10.0.3.0/24", "10.0.6.0/24"]
    validation {
        condition = length(var.public_subnet_cidrs) == 2
        error_message = "Please provide 2 valid public subnet CIDR"
    }
}

variable "public_subnet_tags" {
    default = {}
}

variable "private_subnet_cidrs" {
    type = list
    default = ["10.0.2.0/24", "10.0.5.0/24"]
    validation {
        condition = length(var.private_subnet_cidrs) == 2
        error_message = "Please provide 2 valid private subnet CIDR"
    }
}

variable "private_subnet_tags" {
    default = {}
}

variable "database_subnet_cidrs" {
    type = list
    default = ["10.0.1.0/24", "10.0.4.0/24"]
    validation {
        condition = length(var.database_subnet_cidrs) == 2
        error_message = "Please provide 2 valid database subnet CIDR"
    }
}

variable "sub_domain_names" {
  default = ["backend", "database", "expense"]
}

variable "domain_name" {
    default = "nareshtransportservices.online"
}