
/*
output "wordpress_private_dns" {
  value = "${aws_instance.ec2_wordpress.private_dns}"
}
*/
output "wordpress_instance_id" {
  value = ["${aws_instance.ec2_wordpress.*.id}"]
}

output "private_ip" {
  value = "${aws_instance.ec2_wordpress.*.private_ip}"
}

output "public_ip"  {
  value = "${aws_instance.ec2_wordpress.public_ip}"
}
