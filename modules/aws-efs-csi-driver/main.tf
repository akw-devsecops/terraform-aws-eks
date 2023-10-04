module "aws_efs_csi_irsa_role" {
  count = var.enable_aws_efs_csi_driver_role ? 1 : 0

  source  = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"
  version = "~> 5.0"

  role_name             = var.iam_role_name
  attach_efs_csi_policy = true

  oidc_providers = {
    sts = {
      provider_arn               = var.oidc_provider_arn
      namespace_service_accounts = ["kube-system:efs-csi-controller-sa"]
    }
  }
}

resource "helm_release" "this" {
  count = var.enable_aws_efs_csi_driver ? 1 : 0

  name       = "aws-efs-csi-driver"
  repository = "https://kubernetes-sigs.github.io/aws-efs-csi-driver"
  chart      = "aws-efs-csi-driver"
  namespace  = "kube-system"
  version    = "2.5.0"

  set {
    name  = "controller.serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
    value = module.aws_efs_csi_irsa_role[0].iam_role_arn
  }

  set {
    name  = "controller.resources.requests.cpu"
    value = "10m"
  }

  set {
    name  = "controller.resources.requests.memory"
    value = "64Mi"
  }

  set {
    name  = "controller.resources.limits.memory"
    value = "128Mi"
  }

  set {
    name  = "node.resources.requests.cpu"
    value = "10m"
  }

  set {
    name  = "node.resources.requests.memory"
    value = "64Mi"
  }

  set {
    name  = "node.resources.limits.memory"
    value = "128Mi"
  }
}
