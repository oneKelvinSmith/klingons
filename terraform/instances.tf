data "template_file" "user_data" {
  template = "${file("templates/user_data.tpl")}"

  vars {
    cluster_name = "${aws_ecs_cluster.klingons.name}"
  }
}

resource "aws_launch_configuration" "klingons" {
  name                 = "${var.name}"
  image_id             = "${lookup(var.amis, var.region)}"
  instance_type        = "${var.instance_type}"
  user_data            = "${data.template_file.user_data.rendered}"
  iam_instance_profile = "${aws_iam_instance_profile.klingons_instance.name}"

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

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_iam_instance_profile" "klingons_instance" {
  name = "${var.name}"
  role = "${aws_iam_role.klingons_instance.name}"
}

resource "aws_iam_role" "klingons_instance" {
  name = "${var.name}_instance"

  assume_role_policy = "${file("policies/ecs_service.json")}"
}

resource "aws_iam_role_policy_attachment" "klingons_instance" {
  role = "${aws_iam_role.klingons_instance.name}"
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
}