resource "aws_launch_configuration" "lc" {
  lifecycle { create_before_destroy = true }
  image_id = "${var.image_id}"
  instance_type = "${var.instance_type}"
  #security_groups = [
  #  "${var.webapp_http_inbound_sg_id}",
  #  "${var.webapp_ssh_inbound_sg_id}",
  #  "${var.webapp_outbound_sg_id}"
  #] 
  #key_name = "${var.key_name}"
  associate_public_ip_address = false

  
  provisioner "chef"{
    environment     = "_default"
    run_list        = ["tomcat:default"]
    node_name       = "${var.chef_nodename}"
    server_url      = "${var.chef_server_url}"
    recreate_client = true
    user_name       = "maksym"
    user_key        = "${file("~/terraform-production/launch-configuration/mary1.pem")}"
    ssl_verify_mode = "verify_none"
/*    
    connection{
      type     = "ssh"
      user     = "ec2-user"
      agent = false
      private_key = "${file("~/terraform-production/launch-configuration/key1.pem")}"
    }*/
  }



}
output "lc_id" {
  value = "${aws_launch_configuration.lc.id}"
}
output "lc_name" {
  value = "${aws_launch_configuration.lc.name}"
}
