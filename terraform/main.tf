terraform {
  required_version = "~> 0.10.4"
}

provider "aws" {
  region = "${var.region}"
}

resource "aws_ecs_cluster" "klingons" {
  name = "${var.name}"
}

resource "aws_ecs_task_definition" "klingons" {
  family                = "${var.family}"
  container_definitions = "${file("task_definitions/klingons.json")}"
}

resource "aws_ecs_service" "klingons" {
  name            = "${var.name}"
  cluster         = "${aws_ecs_cluster.klingons.id}"
  task_definition = "${aws_ecs_task_definition.klingons.arn}"
  desired_count   = "${var.desired_count}"
  iam_role        = "${aws_iam_role.klingons_service.arn}"

  load_balancer {
    elb_name       = "${aws_elb.klingons.name}"
    container_name = "${var.name}"
    container_port = "${var.instance_port}"
  }
}

resource "aws_elb" "klingons" {
  name               = "${var.name}"
  availability_zones = "${var.availability_zones}"

  listener {
    instance_port     = "${var.instance_port}"
    instance_protocol = "http"
    lb_port           = "${var.port}"
    lb_protocol       = "http"
  }

  tags {
    Name        = "${var.name}"
    Environment = "${var.environment}"
  }
}

resource "aws_iam_role" "klingons_service" {
  name = "${var.name}_service"

  assume_role_policy = "${file("policies/ecs_service.json")}"
}

resource "aws_iam_role_policy_attachment" "klingons_service" {
  role = "${aws_iam_role.klingons_service.name}"
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceRole"
}