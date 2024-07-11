resource "aws_db_subnet_group" "subnet_group_rds" {
  name       = "${lower(var.project_name)}-subnet-group-rds"
  subnet_ids = [for s in aws_subnet.subnet_default : s.id]

  tags = {
    Name = "${var.project_name} - subnet group - rds"
  }
}