module "cluster_autoscaler_irsa_role" {
  count = var.enable_cluster_autoscaler_role ? 1 : 0

  source  = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"
  version = "~> 5.0"

  role_name = var.iam_role_name

  attach_cluster_autoscaler_policy = true
  cluster_autoscaler_cluster_ids   = [var.cluster_name]

  oidc_providers = {
    sts = {
      provider_arn               = var.oidc_provider_arn
      namespace_service_accounts = ["kube-system:cluster-autoscaler"]
    }
  }
}

locals {
  cluster_autoscaler_version = {
    "1.25" = "v1.25.3"
    "1.26" = "v1.26.4"
    "1.27" = "v1.27.3"
  }
}

resource "helm_release" "this" {
  count = var.enable_cluster_autoscaler ? 1 : 0

  name       = "cluster-autoscaler"
  chart      = "cluster-autoscaler"
  namespace  = "kube-system"
  repository = "https://kubernetes.github.io/autoscaler"
  version    = "9.32.0"

  set {
    name  = "image.tag"
    value = lookup(local.cluster_autoscaler_version, var.cluster_version)
  }

  set {
    name  = "awsRegion"
    value = var.aws_region
  }

  set {
    name  = "autoDiscovery.clusterName"
    value = var.cluster_name
  }

  set {
    name  = "rbac.serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
    value = module.cluster_autoscaler_irsa_role[0].iam_role_arn
  }

  set {
    name  = "extraArgs.skip-nodes-with-system-pods"
    value = false
  }

  set {
    name  = "extraArgs.skip-nodes-with-local-storage"
    value = false
  }

  set {
    name  = "extraArgs.balance-similar-node-groups"
    value = true
  }

  set {
    name  = "rbac.serviceAccount.name"
    value = "cluster-autoscaler"
  }

  set {
    name  = "resources.requests.cpu"
    value = "10m"
  }

  set {
    name  = "resources.requests.memory"
    value = "128Mi"
  }

  set {
    name  = "resources.limits.memory"
    value = "128Mi"
  }
}
