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
  instance_class     = "db.t2.small"
}

