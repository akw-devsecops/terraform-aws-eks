data "aws_region" "current" {}

data "aws_caller_identity" "current" {}

data "aws_iam_session_context" "current" {
  arn = data.aws_caller_identity.current.arn
}

data "aws_subnet" "pods" {
  for_each = toset(var.pod_subnet_ids)

  id = each.key
}
