variable "aws_region" {
  description = "AWS region for VMs"
  default     = "us-east-1"
}


variable "pem_key_name" {
  description = "name of ssh key to attach to hosts genereted during apply"
  default     = "opsschool_consul.pem"
}

variable "key_name" {
  default     = "opsschool_consul.pem"
  description = "name of ssh key to attach to hosts"
}


variable "vpc_cidr_block" {
  default = "10.0.0.0/16"
}

variable "public_subnet" {
  default = "10.0.1.0/24"
}

variable "private_subnet" {
  default = "10.0.10.0/24"
}

variable "num_consul_servers" {
  default = 3
}
variable "num_consul_agents" {
  default = 1
}

## tags
variable "owner_tag" {
  default = "yoad"
}
variable "context_tag" {
  default = "opsschool"
}
variable "purpose_tag" {
  default = "service-discovery-hw"
}
