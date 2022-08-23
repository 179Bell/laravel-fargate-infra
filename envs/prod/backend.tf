terraform {
    backend "s3" {
        bucket = "442649480599-laravel-fargate-tfstate"
        key    = "terraform/terraform.tfstate"
        region = "ap-northeast-1"
    }
}