resource "aws_autoscaling_group" "api-asg" {
    launch_configuration    =   "${aws_launch_configuration.api-asg-conf.id}"
    availability_zones  =   ["${split(",", var.azs)}"]
    name            =   "${var.asg_name}"
    max_size    =   "${var.max_size}"
    min_size    =   "${var.min_size}"
    health_check_grace_period =     "${var.health_check_grace_period}"
    health_check_type   =     "${var.health_check_type}"
    desired_capacity    =   "${var.desired_capacity}"
   vpc_zone_identifier =   ["${var.subnets}"]
#    load_balancers  = ["${var.load_balancers}"]
#    vpc_zone_identifier =   "${element(split(",", var.subnets), count.index)}"
#    target_group_arns = ["${split(",", var.target_group_arns)}"]
    tag {
    key                 = "Name"
    value               = "${var.origin}-${var.env}-asg"
    propagate_at_launch = "true"
  }

  }

resource "aws_launch_configuration" "api-asg-conf" {
    name_prefix =   "${var.launch_config_name}"
    image_id    =   "${var.ami}"
    instance_type   =   "${var.instance_type}"
#    iam_instance_profile    =   "${var.iam}"
    key_name    =   "${var.keyname}"
    security_groups =      ["${var.security_groups}"]
#    user_data = "#!/bin/bash\necho ECS_CLUSTER='${var.ecs_cluster_name}' > /etc/ecs/ecs.config"
    user_data   = "${data.template_file.init.rendered}"
}

data "template_file" "init" {
  template = "${file("wp.tpl")}"
}
