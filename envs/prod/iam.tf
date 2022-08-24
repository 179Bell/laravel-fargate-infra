module "iam_user_for_github" {
    source = "../../aws/modules/iam"

    name = "${var.system_name}-${terraform.workspace}-github"
}