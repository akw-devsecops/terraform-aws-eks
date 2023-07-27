# AWS Load Balancer Controller Module


<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_helm"></a> [helm](#provider\_helm) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_aws_load_balancer_controller_irsa_role"></a> [aws\_load\_balancer\_controller\_irsa\_role](#module\_aws\_load\_balancer\_controller\_irsa\_role) | terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks | ~> 5.0 |

## Resources

| Name | Type |
|------|------|
| [helm_release.this](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | Name of the EKS cluster | `string` | n/a | yes |
| <a name="input_oidc_provider_arn"></a> [oidc\_provider\_arn](#input\_oidc\_provider\_arn) | The ARN of the OIDC Provider | `string` | n/a | yes |
| <a name="input_enable_aws_load_balancer_controller"></a> [enable\_aws\_load\_balancer\_controller](#input\_enable\_aws\_load\_balancer\_controller) | Determines whether to install AWS Load Balancer Controller for EKS | `bool` | `true` | no |
| <a name="input_enable_aws_load_balancer_controller_role"></a> [enable\_aws\_load\_balancer\_controller\_role](#input\_enable\_aws\_load\_balancer\_controller\_role) | Determines whether to install AWS Load Balancer Controller IRSA | `bool` | `true` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->