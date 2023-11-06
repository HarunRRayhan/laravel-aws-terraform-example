module "vpc" {
    source  = "terraform-aws-modules/vpc/aws"
    version = "~> 5.1.0"

    name = "${var.app_name}-vpc"
    cidr = var.vpc_cidr

    azs = var.azs
    public_subnets  = var.public_subnets_cidr
    private_subnets = var.private_subnets_cidr
}
