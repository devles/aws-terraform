resource "aws_subnet" "private0" {

  vpc_id     = "${aws_vpc.app_vpc.id}"
  cidr_block = "${var.vpccidrroot}${var.test_subnet0_cidrrange}"
  availability_zone = "${data.aws_availability_zones.available.names[0]}"
  tags {
    Name = "PrivateSubnet0-${var.environment}"
  }
}

resource "aws_subnet" "private1" {

  vpc_id     = "${aws_vpc.app_vpc.id}"
  cidr_block = "${var.vpccidrroot}${var.test_subnet1_cidrrange}"
  availability_zone = "${data.aws_availability_zones.available.names[1]}"
  tags {
    Name = "PrivateSubnet1-${var.environment}"
  }
}

resource "aws_route_table" "private_routetable0" {
  vpc_id = "${aws_vpc.app_vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = "${aws_nat_gateway.nat_gw.id}"
  }

  tags {
    Name = "PrivateRT0-${var.environment}"
  }
}

resource "aws_route_table" "private_routetable1" {
  vpc_id = "${aws_vpc.app_vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = "${aws_nat_gateway.nat_gw.id}"
  }

  tags {
    Name = "PrivateRT1-${var.environment}"
  }
}

resource "aws_route_table_association" "private_routetable_association0" {
  subnet_id      = "${aws_subnet.private0.id}"
  route_table_id = "${aws_route_table.private_routetable0.id}"
}

resource "aws_route_table_association" "private_routetable_association1" {
  subnet_id      = "${aws_subnet.private1.id}"
  route_table_id = "${aws_route_table.private_routetable1.id}"
}

resource "aws_security_group" "private_sg0" {
  depends_on = [
    "aws_route_table_association.private_routetable_association0",
    "aws_route_table_association.private_routetable_association1"
    ]
  description = "Security Group for first app micro service"
  name = "PrivateSG-${var.environment}"
  vpc_id = "${aws_vpc.app_vpc.id}"
  
  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }
  
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["${var.ingress_ip1}/32"]
  }
  tags {
    Name = "PrivateSG-${var.environment}"
  }
}