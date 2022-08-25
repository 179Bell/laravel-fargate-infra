resource "aws_iam_user" "this" {
    name = var.system_name

    tags = {
      "Name" = var.system_name
    }
}

resource "aws_iam_role" "this" {
    name = var.system_name

    assume_role_policy = var.role_policy

    tags = {
      "Name" = var.system_name
    }
}

data "aws_iam_policy" "ecr_power_user" {
    arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryPowerUser"
}

resource "aws_iam_role_policy_attachment" "role_deployer_policy_ecr_power_user" {
    role       = aws_iam_role.this.name
    policy_arn = data.aws_iam_policy.ecr_power_user.arn
}