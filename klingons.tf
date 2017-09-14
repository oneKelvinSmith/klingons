provider "aws" {}

resource "aws_instance" "klingons" {
  ami           = "ami-8fcc32f6"
  instance_type = "t2.micro"
}