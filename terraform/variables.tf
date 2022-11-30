variable "perfil" {
  default = "default"
}

variable "region" {
  default = "us-east-1"
}

variable "vpc_cidr" {
  default = "172.16.0.0/16"
}

variable "private_subnet" {
  default = "172.16.1.0/24"
}

variable "private_subnet-2" {
  default = "172.16.2.0/24"
}

variable "vpc_aws_az" {
  default = "us-east-1a"
}

variable "vpc_aws_az-2" {
  default = "us-east-1b"
}

data "aws_iam_role" "mi-role" {
  name = "LabRole"
}
