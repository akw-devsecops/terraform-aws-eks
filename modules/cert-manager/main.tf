resource "helm_release" "this" {
  count = var.enable_cert_manager ? 1 : 0

  name       = "cert-manager"
  repository = "https://charts.jetstack.io"
  chart      = "cert-manager"
  namespace  = "kube-system"
  version    = "v1.13.2"

  set {
    name  = "installCRDs"
    value = true
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

  set {
    name  = "extraArgs"
    value = "{--logging-format=json}"
  }
}

resource "kubernetes_manifest" "cluster_issuer_lets_encrypt" {
  count = var.enable_cert_manager && var.enable_cluster_issuer_letsencrypt ? 1 : 0

  manifest = {
    apiVersion = "cert-manager.io/v1"
    kind       = "ClusterIssuer"
    metadata = {
      name = "lets-encrypt"
    }
    spec = {
      acme = {
        email = var.cluster_issuer_letsencrypt_email
        privateKeySecretRef = {
          name = "lets-encrypt"
        }
        server = "https://acme-v02.api.letsencrypt.org/directory"
        solvers = [
          {
            http01 = {
              ingress = {
                ingressClassName = "nginx"
              }
            }
          },
        ]
      }
    }
  }
}
