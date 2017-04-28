output "vpc_cidr" {
  value = "${aws_vpc.app_vpc.cidr_block}"
}
