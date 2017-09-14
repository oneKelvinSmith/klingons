provider "aws" {
  region = "${var.region}"
}

resource "aws_instance" "klingons" {
  ami           = "${lookup(var.amis, var.region)}"
  instance_type = "t2.micro"
}