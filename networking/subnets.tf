resource "aws_subnet" "subnet_default" {
  count                   = length(var.public_subnets)
  vpc_id                  = aws_vpc.vpc_default.id
  cidr_block              = var.public_subnets[count.index]
  availability_zone       = element(data.aws_availability_zones.available.names, count.index)
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.project_name} - public subnet - rds - ${count.index}"
  }
}
