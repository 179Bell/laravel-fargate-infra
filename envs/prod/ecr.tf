module "nginx" {
  source = "../../aws/modules/ecr"

  name = "${var.system_name}-nginx"
}

module "php" {
    source = "../../aws/modules/ecr"

  name = "${var.system_name}-php"
}