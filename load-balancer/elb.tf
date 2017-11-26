# create a new load balancer

#data "aws_availability_zones" "all" {}

resource "aws_elb" "tomcat-elb" {
  name = "tomcat-elb"
  subnets = ["${var.public_subnet_id}"]
  #security_groups = ["sg-f8095b90"]
  security_groups = ["${var.security_groups}"]

  listener {
    instance_port = 8080
    instance_protocol = "http"
    lb_port = 80
    lb_protocol = "http"
  }
/*
  listener {
    instance_port = 8000
    instance_protocol = "http"
    lb_port = 443
    lb_protocol = "https"
    #ssl_certificate_id = ""
  }
*/
  instances = ["${var.servers_id}"]
  cross_zone_load_balancing = true
  idle_timeout = 40
  connection_draining = true
  connection_draining_timeout = 40

  tags{ Name = "tomcat-elb" }
}

output "elb_name"{
  value = "${aws_elb.tomcat-elb.name}"
}
