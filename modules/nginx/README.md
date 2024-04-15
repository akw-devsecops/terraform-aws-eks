# Ingress Nginx Module

<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_eip.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_nlb_eip_count"></a> [nlb\_eip\_count](#input\_nlb\_eip\_count) | Determines the number of Elastic IPs used on the network load balancer | `number` | `0` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->