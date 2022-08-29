variable "system_name" {
  default = "laravel-fargate"
}

variable "vpc_cidr" {
    type = string
    default = "172.31.0.0/16"
}