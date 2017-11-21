variable "availability_zones" {
  default = "us-east-2a,us-east-2b,us-east-2c"
}
variable "asg_min" {
  default = "2"
}
variable "asg_max" {
  default = "10"
}
#
# From other modules
#
variable "public_subnet_id" {
  default = []
}
variable "lc_id" {}
variable "lc_name" {}
variable "elb_name" {}
