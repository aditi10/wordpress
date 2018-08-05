resource "aws_security_group" "rds_sg" {
  tags {
    Name = "${var.env}-rds-sg"
  }

  name        = "${var.env}-${var.application_short}-db"
  description = "${var.env}-${var.application_short}-db"
  vpc_id      = "${aws_vpc.dmz.id}"

}


# Allow outbound for all
resource "aws_security_group_rule" "allow_outbound_rds" {
        type = "egress"
        from_port = 0
        to_port = 0
        protocol = "-1"
	cidr_blocks = ["0.0.0.0/0"]
        security_group_id = "${aws_security_group.rds_sg.id}"
}

