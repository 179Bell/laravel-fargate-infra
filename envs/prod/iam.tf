module "iam_user_for_github" {
    source = "../../aws/modules/iam"

    system_name = "${var.system_name}-github"
    role_policy = templatefile("./iam/deployer.json", 
            {
                arn = module.iam_user_for_github.iam_user_arn
            }
        )
}