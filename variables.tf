variable "aws_region" {
  default = "ap-southeast-1"
}

variable "aws_profile" {
  default = "default"
}

variable "ecs_cluster_name" {
  description = "Name of ecs cluster "
  default = ""
}

variable "vpc_id" {
  description = "ID of VPC in the same region "
  default = ""
}

variable "app_name" {
  default = " "
}

variable "app_short_name" {
  default = ""
}

variable "app_detail" {
  default = ""
}

variable "stack_name" {
  default = ""
}

variable "azs" {
}

variable "name" {
  default = ""
}

variable "task_name" {
  default = ""
}

variable "ec2cluster" {
  default = ""
  description = "Name of ec2 cluster role"
}

