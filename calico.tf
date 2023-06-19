resource "helm_release" "tigera_operator" {
  count = var.enable_calico ? 1 : 0

  name       = "tigera-operator"
  repository = "https://docs.projectcalico.org/charts"
  chart      = "tigera-operator"
  namespace  = "kube-system"
  version    = "v3.26.1"

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
}
