resource "aws_vpc" "student_project" {
  cidr_block       = var.vpc_cidr_block
  enable_dns_hostnames = true

  tags = {
    Name = local.resource_name
  }
}

resource "aws_subnet" "public" {
  count = length(var.public_subnet_cidrs)
  vpc_id     = aws_vpc.student_project.id
  cidr_block = var.public_subnet_cidrs[count.index]
  availability_zone = local.az_names[count.index]
  map_public_ip_on_launch = true
  tags = {
        Name = "${local.resource_name}-public-${local.az_names[count.index]}"
    }
}

resource "aws_subnet" "private" {
  count = length(var.private_subnet_cidrs)
  vpc_id     = aws_vpc.student_project.id
  cidr_block = var.private_subnet_cidrs[count.index]
  availability_zone = local.az_names[count.index]

  tags = {
        Name = "${local.resource_name}-private-${local.az_names[count.index]}"
    }
}

resource "aws_subnet" "database" {
  count = length(var.database_subnet_cidrs)
  vpc_id     = aws_vpc.student_project.id
  cidr_block = var.database_subnet_cidrs[count.index]
  availability_zone = local.az_names[count.index]

  tags = {
        Name = "${local.resource_name}-database-${local.az_names[count.index]}"
  }

}

resource "aws_db_subnet_group" "db_subnet_group" {
  subnet_ids = aws_subnet.database[*].id

  tags = {
        Name = "${local.resource_name}-db_subnet_group"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.student_project.id

  tags = {
    Name = "${local.resource_name}-student-project-igw"
  }
}

resource "aws_eip" "nat_eip" {

  tags = {
    Name = "${local.resource_name}-student-project-nat-eip"
  }
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat_eip.id     # Attach Elastic IP
  subnet_id     = aws_subnet.public[0].id  # Place NAT in a PUBLIC subnet

  tags = {
    Name = "${local.resource_name}-nat-gateway"
  }

  depends_on = [aws_internet_gateway.igw] # Ensure IGW exists first
}

# public route table
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.student_project.id

  tags = {
      Name = "${local.resource_name}-public" 
    }
}

# private route table
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.student_project.id

  tags = {
      Name = "${local.resource_name}-private" 
    }
}

# database route table
resource "aws_route_table" "database" {
  vpc_id = aws_vpc.student_project.id

  tags = {
      Name = "${local.resource_name}-database" 
    }
}


# Routes
resource "aws_route" "public" {
  route_table_id            = aws_route_table.public.id
  destination_cidr_block    = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.igw.id
}

resource "aws_route" "private_nat" {
  route_table_id            = aws_route_table.private.id
  destination_cidr_block    = "0.0.0.0/0"
  nat_gateway_id = aws_nat_gateway.nat.id
}

resource "aws_route" "database_nat" {
  route_table_id            = aws_route_table.database.id
  destination_cidr_block    = "0.0.0.0/0"
  nat_gateway_id = aws_nat_gateway.nat.id
}


resource "aws_route_table_association" "public" {
  count = length(var.public_subnet_cidrs)
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "private" {
  count = length(var.private_subnet_cidrs)
  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "database" {
  count = length(var.database_subnet_cidrs)
  subnet_id      = aws_subnet.database[count.index].id
  route_table_id = aws_route_table.database.id
}


