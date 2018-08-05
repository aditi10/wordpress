resource "aws_db_parameter_group" "backend-db-pg" {
	name			= "${var.db_parameter_group}"
	family			= "${var.db_parameter_group_family}"
	description		= "${var.db_parameter_group}"

	parameter {
		apply_method	= "immediate"
		name		= "max_connections"
		value		= "10000"
  	}
}

resource "aws_db_instance" "rds-backend" {
	identifier		= "${var.rds_instance_name}-${format("%03d",count.index)}-${var.db_type}-${var.small_az}"
	allocated_storage	= "${var.allocated_storage}"
	engine			= "${var.engine}"
	username		  = "${var.username}"
	password 		  = "${var.password}"
	instance_class          = "${var.rds_instance_class}"
	engine_version         = "${var.rds_engine_version}"
	name                   = "${var.database_name}"
	vpc_security_group_ids  = ["${var.rds_security_group_id}"] 
	db_subnet_group_name    = "${aws_db_subnet_group.backend-db-subnet-group.name}"
	parameter_group_name    = "${var.db_parameter_group}"
	multi_az                = "${var.multi_az}"
	storage_type            = "${var.rds_storage_type}"
	apply_immediately       = true
	backup_retention_period = 5
	identifier              = "${var.identifier}"
	storage_encrypted        = false
	skip_final_snapshot	   = true

	tags {
        	Name             = "${var.rds_instance_name}-${format("%03d",count.index)}-${var.db_type}-${var.small_az}"
        	Origin     = "${var.origin}"
        	Environment  = "${var.env}"
    		AWS_Resource	= "${var.resource}"
    		Project		= "${var.project}"
    		Module		= "${var.module}"
        }
}

#resource "aws_db_instance" "rds-backend-replica" {
#	identifier		= "${var.rds_instance_name}-${format("%03d",count.index)}-${var.db_type_replica}-${var.small_az_replica}"
#	replicate_source_db    = "${aws_db_instance.rds-backend.id}"
#	engine_version         = "${var.rds_engine_version}"
#	instance_class         = "${var.rds_instance_class}"
#	name                   = "${var.database_name}"
#	vpc_security_group_ids = ["${var.rds_security_group_id}"]
#	parameter_group_name   = "${var.db_parameter_group}"
#	availability_zone      = "${var.azs}"
#	apply_immediately      = true
#	storage_encrypted      = false
#	skip_final_snapshot    = true
#	storage_type           = "${var.rds_storage_type}"
#	tags {
#	      Name             = "${var.rds_instance_name}-${format("%03d",count.index)}-${var.db_type_replica}-${var.small_az_replica}"
#	      Origin           = "${var.origin}"
#	      Environment      = "${var.env}"
#    AWS_Resource	= "${var.resource}"
#    Project		= "${var.project}"
#    Module		= "${var.module}"
#     }
#}


resource "aws_db_subnet_group" "backend-db-subnet-group" {
	name        = "${var.rds_instance_name}-rds"
	description = "${var.rds_instance_name}-rds"
	subnet_ids  = ["${var.subnets}"]
}
