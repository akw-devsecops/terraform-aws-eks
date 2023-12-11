module "aws_eso_irsa_role" {
  count = var.enable_aws_eso_role ? 1 : 0

  source  = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"
  version = "~> 5.0"

  role_name             = var.iam_role_name
  attach_efs_csi_policy = true

  oidc_providers = {
    sts = {
      provider_arn               = var.oidc_provider_arn
      namespace_service_accounts = ["system:serviceaccount:tools:eso-operator"]
    }
  }
}