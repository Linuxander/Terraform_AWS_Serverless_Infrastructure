resource "aws_db_parameter_group" "param_group_default" {
  name   = "${lower(var.project_name)}-param-group"
  family = "mysql8.0"

  tags = {
    Name = "${var.project_name} - param group"
  }
}

resource "aws_db_instance" "rds_instance_default" {
  identifier             = "${lower(var.project_name)}-rds-instance"
  instance_class         = "db.t3.micro"
  allocated_storage      = 5
  engine                 = "mysql"
  engine_version         = "8.0.35"
  username               = data.aws_ssm_parameter.db_user.value
  password               = data.aws_ssm_parameter.db_user_pw.value
  db_subnet_group_name   = var.target_subnet_group_name
  vpc_security_group_ids = [var.target_security_group_id]
  parameter_group_name   = aws_db_parameter_group.param_group_default.name
  publicly_accessible    = true
  skip_final_snapshot    = true

  provisioner "local-exec" {
    command = <<-EOF
    mysql --host=${self.address} --port=${self.port} --user=${self.username} --password='${self.password}' -e "
      CREATE DATABASE IF NOT EXISTS \`${data.aws_ssm_parameter.db_name.value}\`;
      USE \`${data.aws_ssm_parameter.db_name.value}\`;

      CREATE TABLE IF NOT EXISTS user (
        id INT AUTO_INCREMENT PRIMARY KEY,
        name VARCHAR(255),
        picture BLOB,
        friends TEXT,
        post TEXT
      );

      CREATE TABLE IF NOT EXISTS post (
        id INT AUTO_INCREMENT PRIMARY KEY,
        created DATE,
        author INT,
        title VARCHAR(255),
        content TEXT,
        signature VARCHAR(255),
        replies TEXT,
        FOREIGN KEY (author) REFERENCES user(id)
      );

      CREATE USER IF NOT EXISTS '${data.aws_ssm_parameter.db_user.value}'@'%' IDENTIFIED BY '${data.aws_ssm_parameter.db_user_pw.value}';
      GRANT ALL PRIVILEGES ON \`${data.aws_ssm_parameter.db_name.value}\`.* TO '${data.aws_ssm_parameter.db_user.value}'@'%';

      FLUSH PRIVILEGES;
    "
  EOF
  }
  tags = {
    Name = "${var.project_name} - rds instance"
  }
}
