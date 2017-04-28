variable "access_key" {}
variable "secret_key" {}
variable "region" {
  default = "us-east-1"
}
variable "sshLocation" {
  default = "217.205.197.194/32"
}
variable "keyPairName" {
  default = "Oscar"
}
variable "instance_type" {
  default = "t2.nano"
}
variable "public_subnet" {}
variable "vpc_id" {}
variable "cidr_block" {
  default = "10.4.0.0/16"
}