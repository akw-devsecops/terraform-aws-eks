# AWS Load Balancer Controller Module


<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_aws_load_balancer_controller_irsa_role"></a> [aws\_load\_balancer\_controller\_irsa\_role](#module\_aws\_load\_balancer\_controller\_irsa\_role) | terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks | ~> 5.0 |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_oidc_provider_arn"></a> [oidc\_provider\_arn](#input\_oidc\_provider\_arn) | The ARN of the OIDC Provider | `string` | n/a | yes |
| <a name="input_enable_aws_load_balancer_controller_role"></a> [enable\_aws\_load\_balancer\_controller\_role](#input\_enable\_aws\_load\_balancer\_controller\_role) | Determines whether to install AWS Load Balancer Controller IRSA | `bool` | `true` | no |
| <a name="input_iam_role_name"></a> [iam\_role\_name](#input\_iam\_role\_name) | The name of the IAM role | `string` | `"aws-load-balancer-controller"` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->