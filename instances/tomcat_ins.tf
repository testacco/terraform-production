resource "aws_instance" "tomcat" {
  count = 2
  #ami = "ami-aa1b34cf"
  ami = "${var.ami}"
  availability_zone = "${var.availability_zone}"
  instance_type = "t2.micro"
  key_name = "project_key"
  vpc_security_group_ids = ["${var.security_group}"]
  tags {
    Name = "tomcat-${count.index}"
  }
/*
provisioner "file" {
    source      = "script.sh"
    destination = "/tmp/script.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/script.sh",
      "/tmp/script.sh args",
    ]
  }
*/

provisioner "remote-exec"{
  inline = ["sudo yum install httpd -y"]
  connection ={
       type     = "ssh"
      #host = "${self.public_ip}"
      user     = "${var.user}"
      agent = false
     #secret_key = "~/.ssh/key1.pem"
      private_key = "${file("~/.ssh/key1.pem")}"
}
}

/*
  provisioner "remote-exec"{
    inline = ["sudo sh -i echo '192.168.102.228 chef-server.com chef-server' >> /etc/hosts"]
    connection{
      type     = "ssh"
      #host = "${self.public_ip}"
      user     = "${var.user}"
      agent = false
     #secret_key = "~/.ssh/key1.pem"
      private_key = "${file("~/.ssh/key1.pem")}"
    }

}


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
      user     = "${var.user}"
      agent = false
      private_key = "${file("~/.ssh/key1.pem")}"
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
