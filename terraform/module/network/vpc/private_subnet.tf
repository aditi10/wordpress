resource "aws_subnet" "app_priv_subnet" {
  vpc_id            = "${aws_vpc.dmz.id}"
  cidr_block        = "${element(split(",", var.private_ranges), count.index)}"
  availability_zone = "${element(split(",", var.azs), count.index)}"
  count             = "${length(compact(split(",", var.private_ranges)))}"

  tags {
    Name = "${var.env}-${element(split(",", var.azs), count.index)}-${var.env_pvt}"
  }
  map_public_ip_on_launch = false
}

resource "aws_route_table" "api_rt" {
  vpc_id = "${aws_vpc.dmz.id}"

  tags {
    Name = "${var.application_short}-${var.env}-${var.env_pvt}-${element(split(",", var.small_az), count.index)}"
  }
}

resource "aws_route" "api_rt_natgw" {
  route_table_id         = "${aws_route_table.api_rt.id}"
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id = "${aws_nat_gateway.nat_gw.id}"
}

resource "aws_route_table_association" "api_rta" {
  subnet_id      = "${aws_subnet.app_priv_subnet.0.id}"
  route_table_id = "${aws_route_table.api_rt.id}"
}

resource "aws_route_table_association" "api_rta1" {
  subnet_id      = "${aws_subnet.app_priv_subnet.1.id}"
  route_table_id = "${aws_route_table.api_rt.id}"
}
