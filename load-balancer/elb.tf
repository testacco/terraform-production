# create a new load balancer

data "aws_availability_zones" "all" {}

resource "aws_elb" "tomcat-elb" {
  name = "tomcat-elb"
  subnets = ["${var.public_subnet_id}"]
  #availability_zones = ["us-east-2a"]
  #availability_zones = ["${data.aws_availability_zones.all.names}"] 
/*
  access_logs {
    bucket = "log_bucket"
    bucket_prefix = "elb"
    interval = 60
  }
*/
  listener {
    instance_port = 8000
    instance_protocol = "http"
    lb_port = 80
    lb_protocol = "http"
  }

  listener {
    instance_port = 8000
    instance_protocol = "http"
    lb_port = 80
    lb_protocol = "http"
    #ssl_certificate_id = "arn:aws:iam::123456789012:server-certificate/certName"
  }

  health_check {
    healthy_threshold = 2
    unhealthy_threshold = 2
    timeout = 3
    target = "HTTP:8000/"
    interval = 30
  }

  #instances = ["${module.instances.*.server_id}"]  
  instances = ["${var.servers_id}"]
  cross_zone_load_balancing = true
  idle_timeout = 400
  connection_draining = true
  connection_draining_timeout = 400

  tags {
    Name = "tomcat-elb"
  }
}

output "elb_name"{
  value = "${aws_elb.tomcat-elb.name}"
}
