provider "aws" {
  region  = var.aws_region
  profile = var.aws_profile
}

data "aws_vpc" "vpc-id" {
  id = var.vpc_id
}

data "aws_subnet_ids" "all" {
  vpc_id = data.aws_vpc.vpc-id.id
}

module "ec2" {
  source  = "git@git.vti.com.vn:vticloud/vti_cloud_iac.git//modules/terraform-aws-ecs"

  name = var.name
  task_name = var.task_name
  cluster_name = var.ec2cluster
  ecs_cluster_name = var.ecs_cluster_name 
  app_name       = var.app_name
  app_short_name = var.app_short_name
  app_detail     = var.app_detail
  stack_name     = var.stack_name
  region         = var.aws_region
  vpc            = data.aws_vpc.vpc-id.id
  azs            = "${element([var.azs],1)}"
  subnets        = data.aws_subnet_ids.all.ids

  cluster = {
    "type"              = "EC2",
    "instance_type"     = "t2.medium",
    "ssh_port"          = "22",
    "node_vol_size"     = "1024",
    "node_min_size"     = "4",
    "node_max_size"     = "6",
    "node_desired_size" = "4",
  }

  services = [{
    "name"      = "test-fargate-nginx",
    "task_file" = "${path.cwd}/tasks/nginx.json",
    }
  ]

  tags = [{
    "key"                 = "env",
    "value"               = "test",
    "propagate_at_launch" = "true",
    }
  ]
}

#module "fargate" {
#  source  = "../../"
#  
#  ecs_cluster_name = var.ecs_cluster_name
#  app_name       = ""
#  app_short_name = ""
#  app_detail     = ""
#  stack_name     = ""
#  region         = var.aws_region
#  vpc            = data.aws_vpc.vpc-id.id
#  azs            = [""]
#  subnets        = data.aws_subnet_ids.all.ids
#
#  cluster = {
#    "type" = "FARGATE",
#  }
#
#  services = [{
#      "name" = "test-fargate-nginx",
#      "task_file" = "${path.cwd}/tasks/nginx.json",
#    },
#    {
#      "name" = "test-fargate-wordpress",
#      "task_file" = "${path.cwd}/tasks/wordpress.json"
#    },
#  ]
#}
