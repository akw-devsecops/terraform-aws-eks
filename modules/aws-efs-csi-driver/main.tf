module "aws_efs_csi_irsa_role" {
  count = var.enable_aws_efs_csi_driver_role ? 1 : 0

  source  = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"
  version = "~> 5.0"

  role_name             = var.iam_role_name
  attach_efs_csi_policy = true

  oidc_providers = {
    sts = {
      provider_arn               = var.oidc_provider_arn
      namespace_service_accounts = ["kube-system:efs-csi-controller-sa", "kube-system:efs-csi-node-sa"]
    }
  }
}
