# Ingress Nginx Module

<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |
| <a name="provider_helm"></a> [helm](#provider\_helm) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_eip.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip) | resource |
| [helm_release.this](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_enable_nginx"></a> [enable\_nginx](#input\_enable\_nginx) | Determines whether to install NGINX Ingress Controller for EKS | `bool` | `true` | no |
| <a name="input_nlb_eip_count"></a> [nlb\_eip\_count](#input\_nlb\_eip\_count) | Determines the number of Elastic IPs used on the network load balancer | `number` | `3` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->