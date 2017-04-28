resource "aws_instance" "bastion" {
  instance_type = "${var.instance_type}"
  key_name = "${var.keyPairName}"
  subnet_id = "${var.public_subnet}"
  ami = "ami-80861296"
  vpc_security_group_ids = ["${aws_security_group.bastion_security_group.id}"]

  tags {
    Name = "Bastion"
  }
}

resource "aws_security_group" "bastion_security_group" {

  description = "Bastion Security Group"
  name = "Bastion Security Group"
  vpc_id = "${var.vpc_id}"
  
  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "6"
    cidr_blocks     = ["${var.cidr_block}"]
  }
  
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "6"
    cidr_blocks = ["${var.sshLocation}"]
  }
  tags {
    Name = "Bastion Security Group"
  }
}