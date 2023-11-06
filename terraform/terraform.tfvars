app_name             = "laravel-aws-tf"
vpc_cidr             = "10.0.0.0/16"
azs                  = ["us-east-1a", "us-east-1b", "us-east-1c"]
public_subnets_cidr  = ["10.0.0.0/19", "10.0.32.0/19", "10.0.64.0/19"]
private_subnets_cidr = ["10.0.128.0/19", "10.0.160.0/19", "10.0.192.0/19"]
