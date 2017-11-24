resource "aws_rds_cluster" "db_cluster" {
  cluster_identifier      = "aurora-cluster"
  availability_zones      = ["us-east-2a"]
  database_name           = "mydb"
  master_username         = "mary"
  master_password         = "barfoo268"
  backup_retention_period = 5
  preferred_backup_window = "07:00-09:00"
}

resource "aws_rds_cluster_instance" "cluster_instances" {
  count              = 2
  identifier         = "cluster-instance-${count.index}"
  cluster_identifier = "${aws_rds_cluster.db_cluster.id}"
  instance_class     = "db.t2.nano"
}

resource "aws_db_instance" "default" {
  allocated_storage    = 8
  storage_type         = "gp2"
  engine               = "mysql"
  engine_version       = "5.6.17"
  instance_class       = "db.t1.nano"
  name                 = "production_db"
  username             = "admin"
  password             = "password"
  db_subnet_group_name = "my_database_subnet_group"
  parameter_group_name = "default.mysql5.6"
}

output "db_instance_ip"{
  value = "${var.aws_db_instance.address}"
}

output "db_instance_port"{
  value = "${var.aws_db_instance.port}"
}

output "db_instance_name"{
  value = "${var.aws_db_instance.name}"
}
