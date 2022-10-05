# Provider
variable "region_name" {
description = "name of region"
default = "eu-west-2"
type = string
}


# VPC

variable "cidre_for_vpc" {
description = "cidre for vpc"
default = "10.0.0.0/16"
type = string

}

# Public Subnets

variable "public_sub_1_az1_cidre" {
description = "cidre for public sub 1 az1"
default = "10.0.0.0/24"
type = string

}

variable "public_sub_2_az2_cidre" {
description = "cidre for public sub 2 az2"
default = "10.0.1.0/24"
type = string

}

# Private Subnets

variable "private_sub_1_az1_cidre" {
description = "cidre for private sub 1 az1"
default = "10.0.2.0/24"
type = string

}

variable "private_sub_2_az2_cidre" {
description = "cidre for private sub 2 az2"
default = "10.0.3.0/24"
type = string

}

# Internet Gateway

variable "name_for_internet_gateway" {
description = "name for internet gatway"
default = "igw"
type    = string
  
}

# Route

variable "cidre_for_route" {
description = "cidre for route"
default = "0.0.0.0/0"
type = string

}

# Public Route Table
variable "name_for_public_route_table" {
description = "name for public route table "
default = "public-route-table"
type = string
} 

# Private Route Table
variable "name_for_private_route_table" {
description = "name for private route table "
default = "private-route-table"
type = string
} 

# Private Nat Associations

variable "proj_3_nat_association_1_connectivity_type" {
description = "connectivity type"
default = "private"
type = string
} 


variable "proj_3_nat_association_2_connectivity_type" {
description = "connectivity type"
default = "private"
type = string
}

# EC2 (Ubuntu 18.04 Public)

variable "name_for_instance_1" {
description = "instance name"
default = "proj_3_server_1"
type = string
}


variable "ami" {
description = "type of ami"
default = "ami-05a8c865b4de3b127"
type = string
}

variable "instance_type_1" {
description = "instance type "
default = "t2.micro"
type = string
}
  
variable "key-name" {
description = "key name"
default = "Derek-KP"
type = string
  
}

variable "availability_zone_1" {
description = "availability zone"
default = "eu-west-2a"
type = string
  
}

# EC2 (Ubuntu 18.04 Public)

variable "name_for_instance_2" {
description = "instance name"
default = "proj_3_server_2"
type = string
}

variable "instance_type_2" {
description = "instance type"
default = "t2.micro"
type = string
}
  
variable "availability_zone_2" {
description = "availability zone"
default = "eu-west-2b"
type = string
  
}

# EC2 (Ubuntu 18.04 Private)

variable "name_for_instance_3" {
description = "instance name"
default = "proj_3_server_3"
type = string
}

variable "instance_type_3" {
description = "instance type"
default = "t2.micro"
type = string
}

# EC2 (Ubuntu 18.04 Private)

variable "name_for_instance_4" {
description = "instance name"
default = "proj_3_server_4"
type = string
}

variable "instance_type_4" {
description = "instance type"
default = "t2.micro"
type = string
}
 