data "aws_ssm_parameter" "newrelic_license_key" {
  count = var.enable_newrelic ? 1 : 0

  name = "NewRelicLicenseKey"
}

resource "helm_release" "this" {
  count = var.enable_newrelic ? 1 : 0

  name       = "newrelic-bundle"
  repository = "https://helm-charts.newrelic.com"
  chart      = "nri-bundle"
  namespace  = "kube-system"
  version    = "5.0.69"

  set_sensitive {
    name  = "global.licenseKey"
    value = data.aws_ssm_parameter.newrelic_license_key[0].value
  }

  set {
    name  = "global.cluster"
    value = var.cluster_name
  }

  set {
    name  = "global.lowDataMode"
    value = true
  }

  set {
    name  = "nri-metadata-injection.resources.requests.cpu"
    value = "10m"
  }

  set {
    name  = "nri-metadata-injection.resources.requests.memory"
    value = "32Mi"
  }

  set {
    name  = "newrelic-infrastructure.privileged"
    value = true
  }

  set {
    name  = "newrelic-infrastructure.kubelet.resources.requests.cpu"
    value = "10m"
  }

  set {
    name  = "newrelic-infrastructure.kubelet.resources.requests.memory"
    value = "128Mi"
  }

  set {
    name  = "newrelic-infrastructure.ksm.resources.requests.cpu"
    value = "10m"
  }

  set {
    name  = "newrelic-infrastructure.ksm.resources.requests.memory"
    value = "128Mi"
  }

  set {
    name  = "newrelic-infrastructure.controlPlane.enabled"
    value = false
  }

  set {
    name  = "kube-state-metrics.enabled"
    value = true
  }

  set {
    name  = "kube-state-metrics.resources.requests.cpu"
    value = "10m"
  }

  set {
    name  = "kube-state-metrics.resources.requests.memory"
    value = "128Mi"
  }

  set {
    name  = "nri-kube-events.enabled"
    value = true
  }

  set {
    name  = "nri-kube-events.resources.requests.cpu"
    value = "10m"
  }

  set {
    name  = "nri-kube-events.resources.requests.memory"
    value = "64Mi"
  }

  set {
    name  = "newrelic-logging.enabled"
    value = true
  }

  set {
    name  = "newrelic-logging.fluentBit.criEnabled"
    value = true
  }

  set {
    name  = "newrelic-logging.resources.requests.cpu"
    value = "10m"
  }

  set {
    name  = "newrelic-logging.resources.requests.memory"
    value = "64Mi"
  }
}
