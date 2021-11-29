provider "aws" {
  region = "us-east-1"
}

module "aws_vpc" {
  source = "../"
  cidr_block = "10.10.0.0/16"
  instance_tenancy = "default"
  enabled_vpc = true
  enabled_route_table = true
  enabled_internet_gateway = true
  enabled_subnet = true
  enabled_interface = true
  vpc_tags = {
    created_by = "mahesh"
  }

  subnet_tags = {
    tag = "rahul"
  }
  cidr1 = "10.10.0.0/24"
  cidr2 = "10.10.1.0/24"
  subnet2_tags = {
    tag = "abhi"
  }
  gateway_tags = {
   tag = "kamal"
  }
}

