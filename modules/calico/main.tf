resource "helm_release" "this" {
  count = var.enable_calico ? 1 : 0

  name       = "tigera-operator"
  repository = "https://docs.projectcalico.org/charts"
  chart      = "tigera-operator"
  namespace  = "kube-system"
  version    = "v3.26.4"

  set {
    name  = "installation.kubernetesProvider"
    value = "EKS"
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
    value = "256Mi"
  }

  set {
    name  = "tolerations[0].key"
    value = "arch"
  }

  set {
    name  = "tolerations[0].value"
    value = "arm64"
  }

  set {
    name  = "tolerations[0].effect"
    value = "NoSchedule"
  }
}
