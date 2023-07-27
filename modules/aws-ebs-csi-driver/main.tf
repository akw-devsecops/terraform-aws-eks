module "aws_ebs_csi_irsa_role" {
  count = var.enable_aws_ebs_csi_driver_role ? 1 : 0

  source  = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"
  version = "~> 5.0"

  role_name             = "ebs-csi"
  attach_ebs_csi_policy = true

  oidc_providers = {
    sts = {
      provider_arn               = var.oidc_provider_arn
      namespace_service_accounts = ["kube-system:ebs-csi-controller-sa"]
    }
  }
}

data "aws_eks_addon_version" "this" {
  count = var.enable_aws_ebs_csi_driver ? 1 : 0

  addon_name         = "aws-ebs-csi-driver"
  kubernetes_version = var.cluster_version
  most_recent        = true
}

resource "aws_eks_addon" "this" {
  count = var.enable_aws_ebs_csi_driver ? 1 : 0

  addon_name               = "aws-ebs-csi-driver"
  cluster_name             = var.cluster_name
  addon_version            = data.aws_eks_addon_version.this[0].version
  service_account_role_arn = module.aws_ebs_csi_irsa_role[0].iam_role_arn
  preserve                 = false
}

resource "kubernetes_storage_class_v1" "gp3" {
  count = var.enable_aws_ebs_csi_driver ? 1 : 0

  metadata {
    name = "gp3"
  }

  storage_provisioner    = "ebs.csi.aws.com"
  allow_volume_expansion = true
  volume_binding_mode    = "WaitForFirstConsumer"

  parameters = {
    type = "gp3"
  }
}
