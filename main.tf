
resource "aws_vpc" "my_vpc" {
  count = var.enabled_vpc ? 1 : 0
  cidr_block       = var.cidr_block
  instance_tenancy = var.instance_tenancy
  tags = var.vpc_tags
}
resource "aws_subnet" "my_subnet" {
  count = var.enabled_subnet ? 1 : 0
  vpc_id     = join("", aws_vpc.my_vpc.*.id)
  cidr_block  = var.cidr1
  tags = var.subnet_tags
}

resource "aws_subnet" "my_subnet2" {
  vpc_id     = join("", aws_vpc.my_vpc.*.id)
  cidr_block = var.cidr2
 tags = var.subnet2_tags
}

resource "aws_internet_gateway" "my_gw" {
  count = var.enabled_internet_gateway ? 1 : 0
  vpc_id = join("", aws_vpc.my_vpc.*.id)
  tags = var.gateway_tags
  }

resource "aws_route_table" "my_route_table" {
  count = var.enabled_route_table ? 1 : 0
  vpc_id = join("", aws_vpc.my_vpc.*.id)

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = join("", aws_internet_gateway.my_gw.*.id)
  }
}
resource "aws_route_table_association" "a" {
  subnet_id      = join("", aws_subnet.my_subnet.*.id)
  route_table_id = join("", aws_route_table.my_route_table.*.id)
}
resource "aws_network_interface" "multi-ip" {
  count = var.enabled_interface ? 1 : 0
  subnet_id   = join("", aws_subnet.my_subnet.*.id)
  private_ips = ["10.10.0.10", "10.10.0.11"]
}

resource "aws_eip" "one" {
  vpc                       = true
  network_interface         = join("", aws_network_interface.multi-ip.*.id)
  associate_with_private_ip = "10.10.0.10"
}
resource "aws_nat_gateway" "example" {
  connectivity_type = "private"
  subnet_id         = join("", aws_subnet.my_subnet.*.id)
}

