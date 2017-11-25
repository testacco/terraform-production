# create a new load balancer

#data "aws_availability_zones" "all" {}

resource "aws_elb" "tomcat-elb" {
  name = "tomcat-elb"
  subnets = ["${var.public_subnet_id}"]
  #availability_zones = ["us-east-2a"]
  #security_groups = ["sg-f8095b90"]
  security_groups = ["${var.security_groups}"]
  #availability_zones = ["${data.aws_availability_zones.all.names}"] 

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
    lb_port = 80
    lb_protocol = "http"
    #ssl_certificate_id = "arn:aws:iam::123456789012:server-certificate/certName"
  }
*/
/*
  health_check {
    healthy_threshold = 2
    unhealthy_threshold = 2
    timeout = 3
    target = "HTTP:8000/"
    interval = 30
  }
*/
  #instances = ["${module.instances.*.server_id}"]  
  instances = ["${var.servers_id}"]
  cross_zone_load_balancing = true
  idle_timeout = 40
  connection_draining = true
  connection_draining_timeout = 40

  tags {
    Name = "tomcat-elb"
  }
}

output "elb_name"{
  value = "${aws_elb.tomcat-elb.name}"
}
