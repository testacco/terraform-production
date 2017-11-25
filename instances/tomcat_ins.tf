resource "aws_instance" "tomcat" {
  count = 1  
  ami = "${var.ami}"
  #availability_zone = "${var.availability_zone}"
  subnet_id = "${var.subnet_id}"
  instance_type = "t2.micro"
  key_name = "${var.key_name}"
  vpc_security_group_ids = ["${var.security_group}"]
  #user_data = "${file("/home/centos/terraform-production/instances/tomcat.sh")}"
  #user_data = "sudo yum install httpd -y"
  tags {
    Name = "tomcat-${count.index}"
  }

provisioner "file" {
    source      = "/home/centos/terraform-production/instances/tomcat.sh"
    destination = "/tmp/tomcat.sh"
     connection ={
      type = "ssh"
      user = "${var.user}"
      agent = false
      private_key = "${file("~/.ssh/key1.pem")}"
    }
  }

  provisioner "remote-exec" {
    inline = [
      #"export DATABASE_URL=${var.db_ip}",
      "chmod +x /tmp/tomcat.sh",
      "bash /tmp/tomcat.sh",
      #"export DATABASE_URL=${var.db_ip}",
     # "cd /usr/share/tomcat/webapps/",
     # "wget http://192.168.103.149:8081/nexus/content/repositories/redirect?r=snapshots&g=com.softserveinc&a=edu&v=LATEST/edu-1.0.0-BUILD.war",
    ]
    connection ={
      type = "ssh"
      user = "${var.user}"
      agent = false
      private_key = "${file("~/.ssh/key1.pem")}"
    }
  }

/*
provisioner "file" {
    source      = "/home/centos/edu.war"
    destination = "/usr/share/tomcat/webapps/edu.war"
     connection ={
      type = "ssh"
      user = "${var.user}"
      agent = false
      private_key = "${file("~/.ssh/key1.pem")}"
    }
  }
*/

/*
provisioner "remote-exec"{
  inline = ["sudo sh -c 'echo DATA=/path/data >> ~/.bashrc'"]
  connection ={
    type     = "ssh"
    user     = "${var.user}"
    agent = false
    private_key = "${file("~/.ssh/key1.pem")}"
  }
}
*/
/*
  provisioner "remote-exec"{
    inline = ["sudo sh -c 'echo 192.168.102.228 chef-server.com chef-server >> /etc/hosts'"]
    connection{
      type     = "ssh"
      user     = "${var.user}"
      agent = false
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

output "instance_id"{
  value = "${aws_instance.tomcat.id}"
}
