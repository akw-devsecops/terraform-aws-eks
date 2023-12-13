module "aws_eso_irsa_role" {
  count = var.enable_aws_eso_role ? 1 : 0

  source  = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"
  version = "~> 5.0"

  role_name = var.iam_role_name
  role_policy_arns = {
    eso_tools_operator_policy = aws_iam_policy.this[0].arn
  }

  oidc_providers = {
    sts = {
      provider_arn               = var.oidc_provider_arn
      namespace_service_accounts = ["system:serviceaccount:tools:eso-operator"]
    }
  }
}

data "aws_iam_policy_document" "this" {
  statement {
    effect    = "Allow"
    actions   = ["sts:AssumeRole"]
    resources = ["*"]
  }
}

resource "aws_iam_policy" "this" {
  count = var.enable_aws_eso_role ? 1 : 0

  name   = "eso-tools-operator-policy"
  policy = data.aws_iam_policy_document.this.json
}
