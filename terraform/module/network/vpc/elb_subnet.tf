resource "aws_subnet" "elb_subnet" {
  vpc_id            = "${aws_vpc.dmz.id}"
  cidr_block        = "${element(split(",", var.elb_public_ranges), count.index)}"
  availability_zone = "${element(split(",", var.azs), count.index)}"
  count             = "${length(compact(split(",", var.elb_public_ranges)))}"

  tags {
    Name = "${var.env}-${element(split(",", var.azs), count.index)}-${var.env_lb}"
  }
  map_public_ip_on_launch = true
}

resource "aws_route_table" "elb_rt" {
  vpc_id = "${aws_vpc.dmz.id}"
 route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.dmz_igw.id}"
}
  tags {
    Name = "${var.env_lb}-${var.env}-${var.rt}"
  }
}

resource "aws_route_table_association" "rt_elb" {
    subnet_id = "${aws_subnet.elb_subnet.0.id}"
    route_table_id = "${aws_route_table.elb_rt.id}"
}

resource "aws_route_table_association" "rt_elb1" {
    subnet_id = "${aws_subnet.elb_subnet.1.id}"
    route_table_id = "${aws_route_table.elb_rt.id}"
}
