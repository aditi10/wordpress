
module "vpc" {
	source				= "../../module/network/vpc"
	env                         	= "test"
	region                      	= "us-east-1"
	usecase                     	= "MyVPC"
	usecase1                    	= "nat_gw"
	application_short           	= "MyVPC"
	env_pub                     	= "public"
	env_pvt                     	= "private"
	env_lb                          = "elb"
	rt                          	= "route-table"
	cidr                        	= "10.0.0.0/16"
	small_az                    	= "a"
	azs                         	= "us-east-1d,us-east-1e,us-east-1f"
	public_ranges			= "10.0.4.0/24,10.0.5.0/24"
        private_ranges                  = "10.0.2.0/24,10.0.3.0/24"
	nat_gw_range                	= "10.0.11.0/24"
        rds_ranges                      = "10.0.130.0/24,10.0.131.0/24"
        elb_public_ranges               = "10.0.6.0/24,10.0.7.0/24"
        enable_dns_support              = "true"
        enable_dns_hostnames            = "true"
}

module "wordpress-elb" {
        source                      = "../../module/aws-services/elb/"
        elb_name                    = "wordpress"
        service                     = "elb-wordpress"
        region                      = "us-east-1"
        env                         = "test"
        elb_is_internal             = false
        elb_route53_name            = "wordpress"
        elb_security_group          = "${module.vpc.elb_sg_id}"
        vpc_id                      = "${module.vpc.vpc_id}"
        subnets                     = "${module.vpc.elb_subnet_id}"
        origin                      = "Altayyar"
        health_check_target         = "HTTP:80/index.html"
        healthy_threshold_check     = "2"
        unhealthy_threshold_check   = "2"
        timeout                     = "5"
        interval                    = "6"
        idle_timeout                = "400"
        connection_draining_timeout = "400"
        backend_port1               = "80"
        backend_port                = "80"
        backend_protocol            = "http"
        zone_id_private             = "Z32IWVH5QCFBQX"
        zone_id_public              = "Z2UJYPKK79ACU7"
        instances                   = "${module.wordpress.wordpress_instance_id}"

}


module "wordpress-asg" {
        source                      = "../../module/aws-services/asg/"
        instance_type               = "t2.small"
        ami                         = "ami-759bc50a"
        subnets                     = "${module.vpc.app_subnet_id}"
        env                         = "test"
        region                      = "us-east-1"
        azs                         = "us-east-1d,us-east-1e"
        small_az                    = "d,e"
        launch_config_name          = "wordpress-asg"
        asg_name                    = "wordpress"
        security_groups             = "${module.vpc.wordpress_sg_id}"
        instance_name               = "wp-asg"
        keyname                     = "CoreOS-K8"
        max_size                    = "1"
        min_size                    = "1"
        desired_capacity            = "1"
        health_check_grace_period   = "300"
        health_check_type           = "ELB"
        origin                      = "wordress"
}




module "rds" {
        source                          = "../../module/database/rds"
        rds_instance_name               = "mysql"
        allocated_storage               = 10
        engine                          = "mysql"
        username                        = "mysql123"
        password                        = "mysql123"
        database_name                   = "demo"
        rds_engine_version              = "5.7.16"
        db_type_replica                 = "replica"
        rds_replica_instance_name       = "mysql"
        rds_instance_class              = "db.t2.micro"
        rds_allocated_storage           = "10"
        db_parameter_group              = "mysqldbparameter"
        azs                             = "us-east-1f"
        small_az                        = "f"
        small_az_replica                = "e"
        db_parameter_group_family       = "mysql5.7"
        rds_storage_type                = "gp2"
        rds_security_group_id           = "${module.vpc.rds_sg_id}"
        subnets                         = "${module.vpc.rds_subnet_id}"
        env                             = "demo"
        db_type                         = "master"
        origin                          = "mysql_rds"
        identifier                      = "mysql-demo"
        resource                        = "RDS"
        project                         = "altayyar"
        module                          = "mysql"
        zone_id_private                 = "Z32IWVH5QCFBQX"
        multi_az                        =  "false"
}


module "wordpress" {
        source                          = "../../module/application/wordpress"
        ami_id                          = "ami-759bc50a"
        az                              = "us-east-1d"
	az_var                          = "d"
        number_instances                = 1
        key_name                        = "CoreOS-K8"
        aws_security_group              = "${module.vpc.wordpress_sg_id}"
        subnet_id                       = "${module.vpc.wordpress_public_subnet_id}"
        instance_type                   = "t2.small"
        instance_name                   = "wordpress"
        env                             = "test"
	zone_id_public			= "Z2UJYPKK79ACU7"

} 
