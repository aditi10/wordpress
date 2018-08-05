variable "elb_route53_name" {}

variable "zone_id_public" {}

variable "zone_id_private" {}

#variable "load_balancers" {}

variable "backend_port1" {}

variable "backend_protocol" {}

variable "backend_port" {}

#variable "acm_ssl_cert_arn" {}

variable "instances" {
  type = "list"
}

variable "env" {}
variable "region" {}

variable "vpc_id" {}

variable "elb_name" {}

variable "origin" {}

variable "elb_is_internal" {
  description = "Determines if the ELB is internal or not"
  default     = false
}

variable "elb_security_group" {}

variable "service" {}

variable "subnets" {
  type = "list"
}

variable "healthy_threshold_check" {}

variable "unhealthy_threshold_check" {}

variable "timeout" {}

variable "interval" {}

variable "idle_timeout" {}

variable "connection_draining_timeout" {}

variable "health_check_target" {}

#variable "log_bucket" {}

#variable "log_bucket_prefix" {}

#variable "iam_ssl_cert_arn" {}
