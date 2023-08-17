module "irsa_role" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"
  version = "~> 5.0"

  role_name = "${var.cluster_name}-argocd-controller"
  role_policy_arns = {
    argocd_assume = aws_iam_policy.this.arn
  }

  oidc_providers = {
    sts = {
      provider_arn               = var.oidc_provider_arn
      namespace_service_accounts = ["tools:argocd-server", "tools:argocd-application-controller"]
    }
  }
}

data "aws_iam_policy_document" "this" {
  statement {
    effect    = "Allow"
    actions   = ["sts:AssumeRole"]
    resources = [var.target_role_arn]
  }
}

resource "aws_iam_policy" "this" {
  name   = "argocd-assume-for-remote-cluster"
  policy = data.aws_iam_policy_document.this.json
}
