# VPC
resource "aws_vpc" "proj_3_vpc" {
  cidr_block       = var.cidre_for_vpc
  enable_dns_hostnames = "true"
  instance_tenancy = "default"

  tags = {
    Name = "proj 3 vpc"
  }
}

# Public Subnets

resource "aws_subnet" "public_sub_1_az1" {
  vpc_id     = aws_vpc.proj_3_vpc.id
  cidr_block = var.public_sub_1_az1_cidre
  availability_zone = "eu-west-2a"
  map_public_ip_on_launch = true

  tags = {
    Name = "public sub 1 az1"
  }
}

resource "aws_subnet" "public_sub_2_az2" {
  vpc_id     = aws_vpc.proj_3_vpc.id
  cidr_block = var.public_sub_2_az2_cidre
  availability_zone = "eu-west-2b"
  map_public_ip_on_launch = true


  tags = {
    Name = "public sub 2"
  }
}

# Private Subnets

resource "aws_subnet" "private_sub_1_az1" {
  vpc_id     = aws_vpc.proj_3_vpc.id
  cidr_block = var.private_sub_1_az1_cidre
  availability_zone = "eu-west-2a"
  tags = {
    Name = "private sub 1"
  }
}

resource "aws_subnet" "private_sub_2_az2" {
  vpc_id     = aws_vpc.proj_3_vpc.id
  cidr_block = var.private_sub_2_az2_cidre
  availability_zone = "eu-west-2b"
  tags = {
    Name = "private sub 2"
  }
}


# Internet Gateway

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.proj_3_vpc.id

  tags = {
    Name = var.name_for_internet_gateway
  }
}

# Public Route Table

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.proj_3_vpc.id

  tags = {
    Name = var.name_for_public_route_table
  }
}

# Private Route Table

resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.proj_3_vpc.id

  tags = {
    Name = var.name_for_private_route_table
  }
}

# Public Route Table Association 1

resource "aws_route_table_association" "public_route_table_association_1" {
  subnet_id      = aws_subnet.public_sub_1_az1.id
  route_table_id = aws_route_table.public_route_table.id
  }

# Public Route Table Association 2

resource "aws_route_table_association" "public_route_table_association_2" {
  subnet_id      = aws_subnet.public_sub_2_az2.id
  route_table_id = aws_route_table.public_route_table.id
  }


# Private Route Table Association 1

resource "aws_route_table_association" "private_route_table_association_1" {
  subnet_id      = aws_subnet.private_sub_1_az1.id
  route_table_id = aws_route_table.private_route_table.id
}

# Private Route Table Association 2

resource "aws_route_table_association" "private_route_table_association_2" {
  subnet_id      = aws_subnet.private_sub_2_az2.id
  route_table_id = aws_route_table.private_route_table.id
}

# Private Nat Association

resource "aws_nat_gateway" "proj_3_nat_association_1" {
  connectivity_type = var.proj_3_nat_association_1_connectivity_type
  subnet_id         = aws_subnet.private_sub_1_az1.id
}

resource "aws_nat_gateway" "proj_3_nat_association_2" {
  connectivity_type = var.proj_3_nat_association_2_connectivity_type
  subnet_id         = aws_subnet.private_sub_2_az2.id
}

# Security Groups (proj_3_sec_group)

resource "aws_security_group" "proj_3_sec_group" {
  name        = "security group using terraform"
  description = "security group using terraform"
  vpc_id      = aws_vpc.proj_3_vpc.id

 ingress {
    description      = "TLS from VPC"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

   ingress {
    description      = "TLS from VPC"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

   egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "proj_3_sec_group"
  }
}

# EC2 (Ubuntu 18.04 Public)

resource "aws_instance" "Proj_3_server_1" {
  ami           = var.ami
  instance_type = var.instance_type_1
  count = 1
  key_name = var.key-name
  availability_zone = var.availability_zone_1
  vpc_security_group_ids = [aws_security_group.proj_3_sec_group.id]
  subnet_id   = aws_subnet.public_sub_1_az1.id
  associate_public_ip_address = "true"


  tags = {
  Name = var.name_for_instance_1
  }
  }

# EC2 (Ubuntu 18.04 Public)

resource "aws_instance" "proj_3_server_2" {
  ami           = var.ami
  instance_type = var.instance_type_2
  count = 1
  key_name = var.key-name
  availability_zone = var.availability_zone_2
  vpc_security_group_ids = [aws_security_group.proj_3_sec_group.id]
  subnet_id   = aws_subnet.public_sub_2_az2.id
  associate_public_ip_address = "true"

  tags = {
  Name = var.name_for_instance_2
}
  }

  # EC2 (Ubuntu 18.04 Private)

resource "aws_instance" "proj_3_server_3" {
  ami           = var.ami
  instance_type = var.instance_type_3
  count = 1
  key_name = var.key-name
  availability_zone = var.availability_zone_1
  vpc_security_group_ids = [aws_security_group.proj_3_sec_group.id]
  subnet_id   = aws_subnet.private_sub_1_az1.id
  associate_public_ip_address = "false"

  tags = {
  Name = var.name_for_instance_3
}
  }

    # EC2 (Ubuntu 18.04 Private)

resource "aws_instance" "proj_3_server_4" {
  ami           = var.ami
  instance_type = var.instance_type_4
  count = 1
  key_name = var.key-name
  availability_zone = var.availability_zone_2
  vpc_security_group_ids = [aws_security_group.proj_3_sec_group.id]
  subnet_id   = aws_subnet.private_sub_2_az2.id
  associate_public_ip_address = "false"

  tags = {
  Name = var.instance_type_4
}
  }

  # Data Base Subnet Group

 resource "aws_db_subnet_group" "proj_3_db_group" {
  name       = "main"
  subnet_ids = [aws_subnet.private_sub_1_az1.id, aws_subnet.private_sub_2_az2.id]

  tags = {
    Name = "DB subnet group"
  }
}

# RDS Data Base
  resource "aws_db_instance" "proj_3_RDSDB" {
  allocated_storage    = "10"
  db_name              = "mydb"
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t2.micro"
  username             = "derek"
  password             = "foobarbaz"
  parameter_group_name = "default.mysql5.7"
  skip_final_snapshot  = true
  db_subnet_group_name = aws_db_subnet_group.proj_3_db_group.id
  vpc_security_group_ids = [aws_security_group.proj_3_sec_group.id]
}
# Application Load Balancer

resource "aws_lb" "proj_3_alb" {
  name               = "proj-3-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.proj_3_sec_group.id]
  subnets            = [aws_subnet.public_sub_1_az1.id, aws_subnet.public_sub_2_az2.id]

  enable_deletion_protection = true
  }

  # Application Load Balancer Target Group

resource "aws_alb_target_group" "proj_3_alb_terget_group" {
  name     = "proj-3-alb-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.proj_3_vpc.id
  stickiness {
    type = "lb_cookie"
  }
  # Alter the destination of the health check to be the login page.
  health_check {
    path = "/login"
    port = 80
  }
}

# HTTP Listener

resource "aws_alb_listener" "proj_3_listener_http" {
  load_balancer_arn = aws_lb.proj_3_alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_alb_target_group.proj_3_alb_terget_group.arn
    type             = "forward"
  }
}
