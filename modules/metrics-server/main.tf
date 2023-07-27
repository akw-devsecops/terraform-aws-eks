resource "helm_release" "this" {
  count = var.enable_metrics_server ? 1 : 0

  name       = "metrics-server"
  chart      = "metrics-server"
  namespace  = "kube-system"
  repository = "https://kubernetes-sigs.github.io/metrics-server"
  version    = "3.10.0"

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
