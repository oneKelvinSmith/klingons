terraform {
  required_version = "> 0.9.0"
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

resource "aws_launch_configuration" "klingons" {
  name          = "${var.name}"
  image_id      = "${lookup(var.amis, var.region)}"
  instance_type = "${var.instance_type}"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "klingons" {
  availability_zones   = "${var.availability_zones}"
  name                 = "${var.name}"
  max_size             = "${var.max_size}"
  min_size             = "${var.min_size}"
  desired_capacity     = "${var.desired_count}"
  launch_configuration = "${aws_launch_configuration.klingons.name}"
}
