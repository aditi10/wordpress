resource "aws_instance" "ec2_wordpress" {
	ami			= "${var.ami_id}"
#	availability_zone	= "${var.az}"
        user_data               = "${data.template_file.init.rendered}"
	availability_zone	= "${element(split(",", var.az), count.index)}"
	count			= "${var.number_instances}"
	key_name		= "${var.key_name}"
#	vpc_security_group_ids	= "${element(var.vpc_security_group_ids, count.index)}"
	vpc_security_group_ids = ["${var.aws_security_group}"]
#	subnet_id		= "${var.subnet_id}"
        subnet_id               = "${element(split(",", var.subnet_id), count.index)}" 
#	iam_instance_profile   = "${var.iam}" 
	tags {	
#		tag_name	= "${var.instance_name}-${format("%03d",count.index)}-${var.env}-${element(split(",",var.az_var), count.index)}"		
#		tag_name	= "${lookup(var.tag_name,count.index)}"
   		created_by  	= "${lookup(var.tags,"created_by")}"
    		Name	        = "${var.instance_name}-${format("%03d",count.index)}-${var.env}-${element(split(",",var.az_var), count.index)}"  		
		Environment 	= "${var.env}"
 	 }
	
	instance_type		= "${var.instance_type}"

}

data "template_file" "init" {
  template = "${file("wp.tpl")}"
#  template = "${file(var.wordpress_install)}"
}

