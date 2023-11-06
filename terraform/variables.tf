variable "aws_region" {
    type = string
    default = "us-east-1"
    description = "Choose your default AWS region..."
}

variable "app_name" {
    type = string
    description = "Choose your application name..."
}

variable "vpc_cidr" {
    type = string
}

variable "azs" {
    type = list(string)
    default = ["us-east-1a", "us-east-1b", "us-east-1c"]
}

variable "public_subnets_cidr" {
    type = list(string)
}

variable "private_subnets_cidr" {
    type = list(string)
}

variable "instance_type" {
    type = string
    default = "t3.micro"
}
