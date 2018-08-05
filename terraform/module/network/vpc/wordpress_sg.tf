resource "aws_security_group" "wordpress_sg" {
  tags {
    Name = "${var.env}-wordpress-sg"
  }

 name            = "${var.env}_Wordpress_sg"
 description     = "Security group for Wordpress- ${var.env}"
  vpc_id      = "${aws_vpc.dmz.id}"

}

resource "aws_security_group_rule" "wordpress_80_access" {
        type = "ingress"
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
#        source_security_group_id = "${aws_security_group.bastion_sg.id}"
        security_group_id = "${aws_security_group.wordpress_sg.id}"
}

resource "aws_security_group_rule" "inbound_wordpress_ssh" {
        type = "ingress"
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
#        source_security_group_id = "${aws_security_group.bastion_sg.id}"
        security_group_id = "${aws_security_group.wordpress_sg.id}"
}

# Allow outbound for all
resource "aws_security_group_rule" "allow_outbound_wordpress" {
        type = "egress"
        from_port = 0
        to_port = 0
        protocol = "-1"
	cidr_blocks = ["0.0.0.0/0"]
        security_group_id = "${aws_security_group.wordpress_sg.id}"
}

