module "vpc" {
    source = "../../aws/modules/vpc"

    enable_nat_gateway = false
    system_name = var.system_name
    vpc_cidr = var.vpc_cidr
    azs = ["ap-northeast-1a","ap-northeast-1c"]
    public_subnet = ["172.31.0.0/20","172.31.16.0/20"]
    private_subnet = ["172.31.48.0/20","172.31.64.0/20"]
}