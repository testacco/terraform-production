resource "aws_launch_configuration" "lc" {
  lifecycle { create_before_destroy = true }
  #name = "launch_config"
  image_id = "${var.image_id}"
  instance_type = "${var.instance_type}"
  security_groups = ["sg-3443175c"
  #  "${var.webapp_http_inbound_sg_id}",
  #  "${var.webapp_ssh_inbound_sg_id}",
  #  "${var.webapp_outbound_sg_id}"
  ] 
  key_name = "${var.key_name}"
  associate_public_ip_address = true

  tags = {
    Hostname = "hostname"
}

  provisioner "remote-exec"{
    inline = ["sudo sh -c 'echo 192.168.102.228 chef-server.com chef-server >> /etc/hosts"]
    connection{
      type     = "ssh"
      #host = "${self.public_ip}"
      user     = "ec2-user"
      agent = false
     #secret_key = "~/.ssh/key1.pem" 
      private_key = "${file("~/.ssh/key1.pem")}"
    }

}
/* 
  provisioner "chef"{
    environment     = "_default"
    run_list        = ["tomcat:default"]
    node_name       = "${var.chef_nodename}"
    server_url      = "${var.chef_server_url}"
    recreate_client = true
    user_name       = "maksym"
    user_key        = "${file("~/terraform-production/launch-configuration/mary1.pem")}"
    ssl_verify_mode = "verify_none"
 
    connection{
      type     = "ssh"
      #host = "${self.ip_address}"
      user     = "ec2-user"
      agent = false
      private_key = "${file("~/.ssh/key1.pem")}"
    }
  }
*/


}
output "lc_id" {
  value = "${aws_launch_configuration.lc.id}"
}
output "lc_name" {
  value = "${aws_launch_configuration.lc.name}"
}
