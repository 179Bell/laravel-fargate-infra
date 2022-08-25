output "iam_user_arn" {
    description = "IAM User's arn"
    value = aws_iam_user.this.arn
}