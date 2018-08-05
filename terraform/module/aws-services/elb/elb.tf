resource "aws_elb" "elb" {
  name            = "${var.elb_name}-${var.service}-${var.env}"
#  name		  = "${var.elb_route53_name}"
  subnets         = ["${var.subnets}"]
  internal        = "${var.elb_is_internal}"
  security_groups = ["${var.elb_security_group}"]
#  load_balancers  = "${var.load_balancers}"
#  zone_id_private = "${var.zone_id_private}"
#  zone_id	  = "${var.zone_id_public}"

 # access_logs {
 #   bucket        = "${var.log_bucket}"
 #   bucket_prefix = "${var.log_bucket_prefix}"
 #   interval      = 60
 # }

  listener {
    instance_port     = "${var.backend_port1}"
    instance_protocol = "${var.backend_protocol}"
    lb_port           = 80
    lb_protocol       = "http"
  }
/*
  listener {
    instance_port      = "${var.backend_port}"
    instance_protocol  = "${var.backend_protocol}"
    lb_port            = 443
    lb_protocol        = "https"
    ssl_certificate_id = "${var.acm_ssl_cert_arn}"
  }
*/
  health_check {
    healthy_threshold   = "${var.healthy_threshold_check}"
    unhealthy_threshold = "${var.unhealthy_threshold_check}"
    timeout             = "${var.timeout}"
    target              = "${var.health_check_target}"
    interval            = "${var.interval}"
  }

  instances                   = ["${var.instances}"]
  cross_zone_load_balancing   = true
  idle_timeout                = "${var.idle_timeout}"
  connection_draining         = true
  connection_draining_timeout = "${var.connection_draining_timeout}"

  tags {
    Name = "${var.elb_name}-${var.service}-${var.region}-${var.env}"
    Origin           = "${var.origin}"
    Environment      = "${var.env}"
#    Nmonitor         = "true"
  }
}
