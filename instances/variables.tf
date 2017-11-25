variable "user"{ default = "ec2-user" }
#variable "ami"{ default = "ami-15e9c770"  }
variable "ami"{ default = "ami-cfdafaaa" }
#variable "availability_zone"{ default = "us-east-2a" }
#variable "security_group"{ default = "sg-f8095b90"  }
#variable "subnet_id"{ default = "subnet-3abb9041"  }

variable "security_group"{ default = "sg-e92a7c81"  }
variable "subnet_id"{ default = "subnet-9439d1fc"  }


variable "chef_nodename"{ default = "tomcat" }
variable "chef_server_url"{ default = "https://192.168.103.228/organizations/devops" }

variable "key_name"{}
#variable "db_ip"{}
#variable "db_name"{}
#variable "public_subnet_id"{}
#variable "webapp_http_inbound_sg_id"{}
#variable "reader_endpoint"{}

