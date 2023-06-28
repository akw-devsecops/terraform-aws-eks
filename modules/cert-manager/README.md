# Cert Manager Module

<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_helm"></a> [helm](#provider\_helm) | n/a |
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [helm_release.this](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [kubernetes_manifest.cluster_issuer_lets_encrypt](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/manifest) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cluster_issuer_letsencrypt_email"></a> [cluster\_issuer\_letsencrypt\_email](#input\_cluster\_issuer\_letsencrypt\_email) | Let's Encrypt will use this to contact you about expiring certificates, and issues related to your account. | `string` | `null` | no |
| <a name="input_enable_cert_manager"></a> [enable\_cert\_manager](#input\_enable\_cert\_manager) | Determines whether to install Cert Manager for EKS | `bool` | `true` | no |
| <a name="input_enable_cluster_issuer_letsencrypt"></a> [enable\_cluster\_issuer\_letsencrypt](#input\_enable\_cluster\_issuer\_letsencrypt) | Determines whether to create the LetsEncrypt ClusterIssuer. Can only work when Cert Manager is already set up | `bool` | `true` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->