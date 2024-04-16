# AWS EFS CSI Driver Module

<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_aws_efs_csi_irsa_role"></a> [aws\_efs\_csi\_irsa\_role](#module\_aws\_efs\_csi\_irsa\_role) | terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks | ~> 5.0 |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_oidc_provider_arn"></a> [oidc\_provider\_arn](#input\_oidc\_provider\_arn) | The ARN of the OIDC Provider | `string` | n/a | yes |
| <a name="input_enable_aws_efs_csi_driver_role"></a> [enable\_aws\_efs\_csi\_driver\_role](#input\_enable\_aws\_efs\_csi\_driver\_role) | Determines whether to install EFS CSI Driver IRSA | `bool` | `true` | no |
| <a name="input_iam_role_name"></a> [iam\_role\_name](#input\_iam\_role\_name) | The name of the IAM role | `string` | `"efs-csi"` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->