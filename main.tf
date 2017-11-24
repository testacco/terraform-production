
provider "aws" {
  shared_credentials_file = "~/.aws/credentials/credentials"
  region = "${var.zone}"
}


module "instances" {
  source = "./instances"
  #public_subnet_id = "${var.public_subnet_id}"
  #bastion_ssh_sg_id = "${module.site.bastion_ssh_sg_id}"
  #private_subnet_id = "${module.site.private_subnet_id}"
  #ssh_from_bastion_sg_id = "${module.site.ssh_from_bastion_sg_id}"
  #web_access_from_nat_sg_id = "${module.site.web_access_from_nat_sg_id}"
  #key_name = "${var.key_name}"
}


# load balancer for tomcat servers
module "load-balancer" {
  source = "./load-balancer"
  servers_id = "${module.instances.server_id}"
  public_subnet_id = "${var.public_subnet_id}"
  #http_inbound_sg_id = "${module.site.webapp_http_inbound_sg_id}"
}
/*
# creating template for instance launch 
module "launch-configuration" {
  source = "./launch-configuration"
  #webapp_http_inbound_sg_id = "${module.site.webapp_http_inbound_sg_id}"
  #webapp_ssh_inbound_sg_id = "${module.site.webapp_ssh_inbound_sg_id}"
  #webapp_outbound_sg_id = "${module.site.webapp_outbound_sg_id}"
  key_name = "${var.key_name}"
}
*/

/*
# creating autoscaling-group for tomcat servers
module "autoscaling-group" {
  source = "./autoscaling-group"
  public_subnet_id = "${var.public_subnet_id}"
  #lc_id = "${module.launch-configuration.lc_id}"
  #lc_name = "${module.launch-configuration.lc_name}"
  elb_name = "${module.load-balancer.elb_name}"
}
*/

#module "rds"{
#  source = "./rds"
#}


