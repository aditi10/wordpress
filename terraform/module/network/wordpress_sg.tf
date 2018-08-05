resource "aws_security_group" "jenkins_sg" {
	tags {
    		Name 	= "${var.env}_jenkins_sg"
  	}
	name		= "${var.env}_jenkins_sg"
	description 	= "Security group for jenkins-${var.env}"
	vpc_id 		= "${aws_vpc.dmz.id}"
}


resource "aws_security_group_rule" "inbound_jenkinsself_sg_9000" {
        type = "ingress"
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        security_group_id = "${aws_security_group.jenkins_sg.id}"
}

resource "aws_security_group_rule" "inbound_jenkins_ssh" {
        type = "ingress"
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        security_group_id = "${aws_security_group.jenkins_sg.id}"
}





# Allow outbound

resource "aws_security_group_rule" "outbound_jenkins_allow_all" {
        type = "egress"
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
        security_group_id = "${aws_security_group.jenkins_sg.id}"
}


