resource "aws_vpc_dhcp_options" "dns_resolver" {
  domain_name_servers = ["AmazonProvidedDNS"]
}

resource "aws_vpc" "app_vpc" {
  cidr_block = "${var.vpccidrroot}.0.0/16"
  tags {
    Name = "${var.vpc_name}"
  }
}

resource "aws_vpc_dhcp_options_association" "dns_resolver" {
  vpc_id          = "${aws_vpc.app_vpc.id}"
  dhcp_options_id = "${aws_vpc_dhcp_options.dns_resolver.id}"
}

resource "aws_internet_gateway" "i_gateway" {
  vpc_id = "${aws_vpc.app_vpc.id}"

  tags {
    Network = "Public"
  }
}

data "aws_availability_zones" "available" {}

resource "aws_subnet" "public" {
  vpc_id     = "${aws_vpc.app_vpc.id}"
  cidr_block = "${var.vpccidrroot}.1.0/24"
  map_public_ip_on_launch = "true"
  availability_zone = "${data.aws_availability_zones.available.names[0]}"

  tags {
    Name = "PublicSubnet-${var.environment}"
  }
}

resource "aws_route_table" "public_routetable" {
  vpc_id = "${aws_vpc.app_vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.i_gateway.id}"
  }

  tags {
    Name = "Public"
  }
}

resource "aws_route_table_association" "public_routetable_association" {
  subnet_id      = "${aws_subnet.public.id}"
  route_table_id = "${aws_route_table.public_routetable.id}"
}

resource "aws_eip" "nat_eip" {
  vpc      = true
}

resource "aws_nat_gateway" "nat_gw" {
  allocation_id = "${aws_eip.nat_eip.id}"
  subnet_id     = "${aws_subnet.public.id}"
  depends_on = [
    "aws_route_table_association.public_routetable_association",
    "aws_vpc_dhcp_options_association.dns_resolver"
    ]
}