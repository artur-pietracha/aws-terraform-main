terraform {
  required_version = ">=0.12"
}

provider "aws" {
  region = "eu-central-1"
}


module "webserver_cluster" {
  source = "..\/..\/..\/..\/modules\/services\/web-servers-cluster"
  cluster_name = "webserver-prod"
  instance_type = "t2.micro"
  min_size = 2
  max_size = 10
}


resource "aws_autoscaling_schedule" "scale_out_business_hours" {
  scheduled_action_name = "scale-out-during-business-hours"
  autoscaling_group_name = module.webserver_cluster.asg_name
  min_size = 2
  max_size = 10
  desired_capacity = 10
  recurrence = "0 9 * * *"
}

resource "aws_autoscaling_schedule" "scale_in_at_night" {
  scheduled_action_name = "scale-in-at-night"
  autoscaling_group_name = module.webserver_cluster.asg_name
  min_size = 2
  max_size = 10
  desired_capacity = 2
  recurrence = "0 17 * * *"
}
