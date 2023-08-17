module "irsa_role" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-assumable-role"
  version = "~> 5.0"

  create_role = true

  role_name         = "argocd-access-from-${var.remote_cluster_name}"
  role_requires_mfa = false

  trusted_role_arns = [var.trusted_role_arn]
}
