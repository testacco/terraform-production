variable "servers_id" {
  default = []
}

variable "security_groups" {
  default = ["sg-e92a7c81"]
}

variable "public_subnet_id" {
  default = ["subnet-9439d1fc"]
  #default = ["subnet-8521d5ed", "subnet-3abb9041"]
}
