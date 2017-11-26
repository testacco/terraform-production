
resource "aws_rds_cluster" "db_cluster" {
  cluster_identifier      = "aurora-cluster"
  database_name           = "${var.db_name}"
  master_username         = "${var.db_user}"
  master_password         = "${var.db_pass}"
  vpc_security_group_ids = ["sg-58500d30"]
  #backup_retention_period = 5
  #preferred_backup_window = "07:00-09:00"
}

resource "aws_rds_cluster_instance" "cluster_instances" {
  count              = 1
  identifier         = "cluster-instance-${count.index}"
  cluster_identifier = "${aws_rds_cluster.db_cluster.id}"
  instance_class     = "db.t2.small"
}
/*
resource "aws_db_instance" "instance" {
  allocated_storage    = 8
  storage_type         = "gp2"
  engine               = "mariadb"
  engine_version       = "10.1.26"
  instance_class       = "db.t2.micro"
  name                 = "production_db"
  username             = "admin"
  password             = "password"
  #db_subnet_group_name = "my_database_subnet_group"
  #parameter_group_name = "default.mysql5.6"
}

output "db_instance_ip"{
  value = "${aws_db_instance.instance.address}"
}

output "db_instance_port"{
  value = "${aws_db_instance.instance.port}"
}

output "db_name"{
  value = "${aws_db_cluster.db_cluster.database_name}"
}
*/

output "reader_endpoint"{
  value = "${aws_rds_cluster.db_cluster.reader_endpoint}"
}

output "cluster_endpoint"{
  value = "${aws_rds_cluster.db_cluster.endpoint}"
}


