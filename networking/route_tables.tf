resource "aws_route_table" "route_table_rds" {
  vpc_id = aws_vpc.vpc_default.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway_default.id
  }
  tags = {
    Name = "${var.project_name} - route table - rds"
  }
}

resource "aws_route_table_association" "rout_table_subnet_association" {
  count          = length(aws_subnet.subnet_default.*.id)
  subnet_id      = aws_subnet.subnet_default[count.index].id
  route_table_id = aws_route_table.route_table_rds.id
}