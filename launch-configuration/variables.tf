variable "region"{
  default = "us-east-2a"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "image_id"{
  default = "ami-aa1b34cf"
}

variable "user"{
  default = ""
}

variable "chef_nodename"{
  default = "tomcat"
}

variable "chef_server_url"{
  default = "https://192.168.103.138/organizations/devops"
}


#variable "webapp_http_inbound_sg_id" {}
#variable "webapp_ssh_inbound_sg_id" {}
#variable "webapp_outbound_sg_id" {}
