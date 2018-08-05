resource "aws_security_group" "elb_sg" {
    name       = "${var.env}-${var.region}-${var.application_short}-${var.env_lb}"
    description ="${var.env}-${var.region}-${var.application_short}-${var.env_lb}"
    vpc_id = "${aws_vpc.dmz.id}"

  tags {
    Name = "${var.env}-${var.region}-${var.application_short}-${var.env_lb}"
  }


    ingress {
        from_port = 9000
        to_port = 9010
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }



/*
    egress {
        from_port = 9000
        to_port = 9010
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
*/
}
