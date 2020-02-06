terraform {
  required_version = ">=0.12"
}

provider "aws" {
  region = "eu-central-1"
}


module "webserver_cluster" {
  source = "..\/..\/..\/..\/modules\/services\/web-servers-cluster"
  cluster_name = "webserver-stage"
  instance_type = "t2.micro"
  min_size = 2
  max_size = 2
}