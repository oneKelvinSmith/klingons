variable "region" {
  default = "eu-west-1"
}

variable "amis" {
  type = "map"

  description = "Images AMIs compatible with ECS"
  default = {
    "eu-west-1" = "ami-8fcc32f6"
    "eu-west-2" = "ami-cb1101af"
  }
}

variable "instance_type" {
  description = "Size of the EC2 instance"
  default     = "t2.micro"
}

variable "name" {
  description = "The name of the domain"
  default     = "klingons"
}

variable "family" {
  description = "The name of the family"
  default     = "Martok"
}

variable "environment" {
  description = "The name of the environment"
  default     = "production"
}

variable "cluster" {
  description = "The name of the ECS cluster"
  default     = "default"
}

variable "port" {
  description = "The port the VPC gateway will use for HTTP requests"
  default     = 8080
}

variable "instance_port" {
  description = "The port the container will use for HTTP requests"
  default     = 4000
}

variable "vpc_cidr" {
  description = "VPC cidr block."
  default     = "10.0.0.0/16"
}

variable "availability_zones" {
  type = "list"

  description = "Multiple zones where the subnet is available"
  default     = ["eu-west-1a", "eu-west-1b"]
}

variable "public_cidr_blocks" {
  type = "list"

  description = "The public subnet CIDRs"
  default     = ["10.0.0.0/24", "10.0.1.0/24"]
}

variable "private_cidr_blocks" {
  type = "list"

  description = "The private subnet CIDRs"
  default     = ["10.0.50.0/24", "10.0.51.0/24"]
}

variable "max_size" {
  description = "The maximum number of instances"
  default     = 1
}

variable "min_size" {
  description = "The minimum number of instances"
  default     = 1
}

variable "desired_count" {
  description = "The  desired capacity of the cluster"
  default     = 1
}
