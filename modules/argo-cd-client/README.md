# Argo CD IRSA Client Module

<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_irsa_role"></a> [irsa\_role](#module\_irsa\_role) | terraform-aws-modules/iam/aws//modules/iam-assumable-role | ~> 5.0 |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_remote_cluster_name"></a> [remote\_cluster\_name](#input\_remote\_cluster\_name) | The name management cluster | `string` | n/a | yes |
| <a name="input_trusted_role_arn"></a> [trusted\_role\_arn](#input\_trusted\_role\_arn) | ARN of AWS entity who can assume this role | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->