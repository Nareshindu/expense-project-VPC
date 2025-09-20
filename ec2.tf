resource "aws_instance" "web" {
  ami           = data.aws_ami.rhel9_devops.id
  instance_type = "t3.micro"
  subnet_id     = aws_subnet.public[0].id
  vpc_security_group_ids = [aws_security_group.frontend_sg.id]



  tags = {
        Name = "${local.resource_name}-web-server"
  }
}


resource "aws_instance" "backend" {
  ami           = data.aws_ami.rhel9_devops.id
  instance_type = "t3.micro"
  subnet_id     = aws_subnet.private[0].id  # goes to private subnet
  vpc_security_group_ids = [aws_security_group.backend_sg.id]

    # No public IP since it's in a private subnet

  tags = {
    Name = "${local.resource_name}-backend-server"
  }
}

resource "aws_instance" "database" {
  ami           = data.aws_ami.rhel9_devops.id
  instance_type = "t3.micro"
  subnet_id     = aws_subnet.database[0].id  # goes to db subnet
  vpc_security_group_ids = [aws_security_group.db_sg.id]

    # No public IP since it's in a private subnet

  tags = {
    Name = "${local.resource_name}-database-server"
  }
}

resource "aws_instance" "bastion" {
  ami           = data.aws_ami.rhel9_devops.id
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.public[0].id  # Bastion must be in public subnet
  associate_public_ip_address = true       # Public IP required
  vpc_security_group_ids      = [aws_security_group.bastion_sg.id]



  tags = {
    Name = "${local.resource_name}-bastion-host"
  }
}
