resource "aws_route53_record" "elb-route-53-private" {
  zone_id = "${var.zone_id_private}"
  name    = "${var.service}-${format("%03d",count.index)}-private-${var.region}"
#  name	  = "${var.elb_route53_name}"
  type    = "A"
  
  alias {
    name                   = "${aws_elb.elb.dns_name}"
    zone_id                = "${aws_elb.elb.zone_id}"
    evaluate_target_health = true
  }

}

resource "aws_route53_record" "elb-route-53-public" {
  zone_id = "${var.zone_id_public}"
#  name    = "${var.service}-${format("%03d",count.index)}-public-${var.region}"
  name    = "${var.elb_route53_name}"
  type    = "A"

  alias {
    name                   = "${aws_elb.elb.dns_name}"
    zone_id                = "${aws_elb.elb.zone_id}"
    evaluate_target_health = true
  }

}
