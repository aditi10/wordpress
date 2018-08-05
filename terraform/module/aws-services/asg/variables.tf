/*
variable "load_balancers" {
type = "list"
}
*/
#variable "wordpress_install" {}
variable "instance_type" {}

variable "instance_name" {}

#variable "ecs_cluster_name" {}
#variable "iam" {}

variable "env" {}

variable "region" {}

variable "ami" {}

variable "azs" {}

variable "security_groups" {}

variable "small_az" {}

variable "asg_name" {}

variable "keyname" {}

variable "target_group_arns" {
  default = ""
}

variable "max_size" {}

variable "min_size" {}

variable "desired_capacity" {}

variable "health_check_grace_period" {}

variable "health_check_type"  {}

#variable "target_group_arns" {}

variable "launch_config_name" {}

variable "origin" {}

variable "subnets" {
type = "list"
}
