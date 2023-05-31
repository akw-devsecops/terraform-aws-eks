module "aws_ebs_csi_irsa_role" {
  count  = var.enable_aws_ebs_csi_driver ? 1 : 0
  source = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"


  role_name             = "ebs-csi"
  attach_ebs_csi_policy = true

  oidc_providers = {
    sts = {
      provider_arn               = module.eks.oidc_provider_arn
      namespace_service_accounts = ["kube-system:ebs-csi-controller-sa"]
    }
  }
}

data "aws_eks_addon_version" "aws_ebs_csi_driver" {
  count = var.enable_aws_ebs_csi_driver ? 1 : 0

  addon_name         = "aws-ebs-csi-driver"
  kubernetes_version = module.eks.cluster_version
  most_recent        = true
}

resource "aws_eks_addon" "aws_ebs_csi_driver" {
  count = var.enable_aws_ebs_csi_driver ? 1 : 0

  addon_name               = "aws-ebs-csi-driver"
  cluster_name             = module.eks.cluster_name
  addon_version            = data.aws_eks_addon_version.aws_ebs_csi_driver[0].version
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
