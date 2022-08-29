variable "system_name" {
    type = string
}

variable "enable_dns_hostnames" {
    type = bool
    default = true
}

variable "vpc_cidr" {
   type = string
}

variable "enable_dns_support" {
    type = bool
    default = true
}

variable "azs" {
    type = list(string)
}

variable "public_subnet" {
    type = list(string)
}

variable "private_subnet" {
    type = list(string)
}

variable "map_public_ip_on_launch" {
    type = bool
    default = true
}

variable "enable_nat_gateway" {
    type = bool
    default = true
}
variable "single_nat_gateway" {
    type    = bool
    default = true
}