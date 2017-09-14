variable "region" {
  default = "eu-west-1"
}

variable "amis" {
  type = "map"
  default = {
    "eu-west-1" = "ami-8fcc32f6"
    "eu-west-2" = "ami-cb1101af"
  }
}