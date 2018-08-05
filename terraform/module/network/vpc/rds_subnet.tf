# All DB related subnet go in this section

resource "aws_subnet" "rds-subnet" {
  vpc_id            = "${aws_vpc.dmz.id}"
  cidr_block        = "${element(split(",", var.rds_ranges), count.index)}"
  availability_zone = "${element(split(",", var.azs), count.index)}"
  count             = "${length(compact(split(",", var.rds_ranges)))}"

  tags {
    Name = "${var.env}-${element(split(",", var.azs), count.index)}-rds"
  }
}

