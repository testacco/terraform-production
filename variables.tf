variable "zone"{ default = "us-east-2"}
variable "public_subnet_id"{default = ["subnet-9439d1fc"]}
#variable "public_subnet_id"{ default = ["subnet-8521d5ed"]}
variable "key_name"{ default = "project_key" }
variable "db_user" {default = "mary"}
variable "db_pass" {default = "password"}
variable "db_name" {default = "production_db"}
