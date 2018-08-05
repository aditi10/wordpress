output "elb_subnet_id" {
        value = ["${aws_subnet.elb_subnet.*.id}"]
}

output "elb_sg_id" {
        value = "${aws_security_group.elb_sg.id}"
}

output "app_subnet_id" {
  value = ["${aws_subnet.app_subnet.*.id}"]
}


output "vpc_id" {
        value = "${aws_vpc.dmz.id}"
}


output "rds_subnet_id" {
        value = ["${aws_subnet.rds-subnet.*.id}"]
}

output "rds_sg_id" {
        value = "${aws_security_group.rds_sg.id}"
}
output "wordpress_sg_id" {
        value = "${aws_security_group.wordpress_sg.id}"
}

output "wordpress_public_subnet_id" {
#	value = "${aws_subnet.app_subnet.id}" 
	value = "${join(",", aws_subnet.app_subnet.*.id)}"
}

/*
output "jenkins_public_subnet_id" {
#	value = "${aws_subnet.app_subnet.id}" 
	value = "${join(",", aws_subnet.app_subnet.*.id)}"
}

output "jenkins_sg_id" {
        value = "${aws_security_group.jenkins_sg.id}"
}
*/
