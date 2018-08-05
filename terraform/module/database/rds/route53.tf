resource "aws_route53_record" "rds-route-53-private" {
  zone_id = "${var.zone_id_private}"
# mane=mysql-private
  name    = "${var.rds_instance_name}-private"
#  name   = "${var.rds_route53_name}"
  type    = "CNAME"
  records = ["${aws_db_instance.rds-backend.address}"]
  ttl     = "300"
}

