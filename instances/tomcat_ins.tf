resource "aws_instance" "tomcat" {
  count = 2
  ami = "ami-aa1b34cf"
  instance_type = "t2.micro"
  tags {
    Name = "tomcat-${count.index}"
  }
/*
  provisioner "chef"{
    environment     = "_default"
    run_list        = ["tomcat:default"]
    node_name       = "${var.chef_nodename}"
    server_url      = "${var.chef_server_url}"
    recreate_client = true
    user_name       = "maksym"
    user_key        = "${file("~/terraform-production/instances/mary.pem")}"
    ssl_verify_mode = "verify_none"

    connection{
      type     = "ssh"
      user     = "${ec2-user}"
      agent = false
      private_key = "${file("~/terraform-production/instances/key.pem")}"
    }
  }
*/
}

output "server_name" {
  value = ["${aws_instance.tomcat.*.name}"]
}

output "server_id"{
  value = ["${aws_instance.tomcat.*.id}"]
}
