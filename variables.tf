
variable "aws_region" {
  type    = string
  default = "eu-north-1"
}

variable "instance_type" {
  type    = string
  default = "t3.micro"
}

variable "public_key_path" {
  type    = string
  default = "~/.ssh/wsl_deploy_key.pub"
  description = "Path to the public key that will be registered in AWS"
}

variable "key_name" {
  type    = string
  default = "wsl_deploy_key"
}

variable "ssh_allowed_cidr" {
  type    = string
  default = "0.0.0.0/0"
  description = "CIDR allowed for SSH. For security put your IP like 203.0.113.5/32"
}

variable "project_name" {
  type    = string
  default = "wsl-demo"
}
