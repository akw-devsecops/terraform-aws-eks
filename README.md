# AWS EKS Module

Terraform Module to set up an AWS EKS cluster. 

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.2 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.40 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 5.40 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_argo_cd_application_management_client"></a> [argo\_cd\_application\_management\_client](#module\_argo\_cd\_application\_management\_client) | ./modules/argo-cd-client | n/a |
| <a name="module_argo_cd_cluster_management_client"></a> [argo\_cd\_cluster\_management\_client](#module\_argo\_cd\_cluster\_management\_client) | ./modules/argo-cd-client | n/a |
| <a name="module_argo_cd_controller"></a> [argo\_cd\_controller](#module\_argo\_cd\_controller) | ./modules/argo-cd-controller | n/a |
| <a name="module_aws_ebs_csi_driver"></a> [aws\_ebs\_csi\_driver](#module\_aws\_ebs\_csi\_driver) | ./modules/aws-ebs-csi-driver | n/a |
| <a name="module_aws_efs_csi_driver"></a> [aws\_efs\_csi\_driver](#module\_aws\_efs\_csi\_driver) | ./modules/aws-efs-csi-driver | n/a |
| <a name="module_aws_load_balancer_controller"></a> [aws\_load\_balancer\_controller](#module\_aws\_load\_balancer\_controller) | ./modules/aws-load-balancer-controller | n/a |
| <a name="module_cluster_autoscaler"></a> [cluster\_autoscaler](#module\_cluster\_autoscaler) | ./modules/cluster-autoscaler | n/a |
| <a name="module_eks"></a> [eks](#module\_eks) | terraform-aws-modules/eks/aws | ~> 20.0 |
| <a name="module_eso_irsa_role"></a> [eso\_irsa\_role](#module\_eso\_irsa\_role) | ./modules/eso-irsa-role | n/a |
| <a name="module_nginx"></a> [nginx](#module\_nginx) | ./modules/nginx | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_autoscaling_group_tag.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_group_tag) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_session_context.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_session_context) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |
| [aws_subnet.pods](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnet) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_admin_roles"></a> [admin\_roles](#input\_admin\_roles) | ARN of the admin roles that will be added as AmazonEKSClusterAdminPolicy | `set(string)` | n/a | yes |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | Name of the EKS cluster | `string` | n/a | yes |
| <a name="input_cluster_version"></a> [cluster\_version](#input\_cluster\_version) | Kubernetes `<major>.<minor>` version to use for the EKS cluster (i.e.: `1.22`) | `string` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | ID of the VPC where the cluster and its nodes will be provisioned | `string` | n/a | yes |
| <a name="input_additional_access_entries"></a> [additional\_access\_entries](#input\_additional\_access\_entries) | Map of access entries to add to the cluster | `any` | `{}` | no |
| <a name="input_argo_cd_application_management_cluster_name"></a> [argo\_cd\_application\_management\_cluster\_name](#input\_argo\_cd\_application\_management\_cluster\_name) | The name of the application management cluster | `string` | `""` | no |
| <a name="input_argo_cd_cluster_management_cluster_name"></a> [argo\_cd\_cluster\_management\_cluster\_name](#input\_argo\_cd\_cluster\_management\_cluster\_name) | The name of the cluster management cluster | `string` | `""` | no |
| <a name="input_argo_cd_remote_target_iam_role_arns"></a> [argo\_cd\_remote\_target\_iam\_role\_arns](#input\_argo\_cd\_remote\_target\_iam\_role\_arns) | The name of the IAM roles to assume for remote cluster management | `set(string)` | `[]` | no |
| <a name="input_aws_lb_iam_role_name"></a> [aws\_lb\_iam\_role\_name](#input\_aws\_lb\_iam\_role\_name) | The name of the aws-load-balancer-controller IAM role | `string` | `"aws-load-balancer-controller"` | no |
| <a name="input_cluster_autoscaler_iam_role_name"></a> [cluster\_autoscaler\_iam\_role\_name](#input\_cluster\_autoscaler\_iam\_role\_name) | The name of the cluster-autoscaler IAM role | `string` | `"cluster-autoscaler"` | no |
| <a name="input_cluster_enabled_log_types"></a> [cluster\_enabled\_log\_types](#input\_cluster\_enabled\_log\_types) | A list of the desired control plane logs to enable. For more information, see Amazon EKS Control Plane Logging documentation (https://docs.aws.amazon.com/eks/latest/userguide/control-plane-logs.html) | `list(string)` | `[]` | no |
| <a name="input_cluster_support_type"></a> [cluster\_support\_type](#input\_cluster\_support\_type) | The support type for the cluster. Can be either `STANDARD` or `EXTENDED` | `string` | `"STANDARD"` | no |
| <a name="input_control_plane_subnet_ids"></a> [control\_plane\_subnet\_ids](#input\_control\_plane\_subnet\_ids) | A list of subnet IDs where the EKS cluster control plane (ENIs) will be provisioned. Used for expanding the pool of subnets used by nodes/node groups without replacing the EKS control plane | `list(string)` | `[]` | no |
| <a name="input_coredns_additional_zones"></a> [coredns\_additional\_zones](#input\_coredns\_additional\_zones) | Additional zones to be placed in CoreDNS Corefile. | `string` | `""` | no |
| <a name="input_ebs_iam_role_name"></a> [ebs\_iam\_role\_name](#input\_ebs\_iam\_role\_name) | The name of the ebs-csi IAM role | `string` | `"ebs-csi"` | no |
| <a name="input_efs_iam_role_name"></a> [efs\_iam\_role\_name](#input\_efs\_iam\_role\_name) | The name of the efs-csi IAM role | `string` | `"efs-csi"` | no |
| <a name="input_eks_managed_node_groups"></a> [eks\_managed\_node\_groups](#input\_eks\_managed\_node\_groups) | Map of EKS managed node group definitions to create | `any` | `{}` | no |
| <a name="input_enable_aws_ebs_csi_driver_role"></a> [enable\_aws\_ebs\_csi\_driver\_role](#input\_enable\_aws\_ebs\_csi\_driver\_role) | Determines whether to install EBS CSI Driver IRSA | `bool` | `false` | no |
| <a name="input_enable_aws_efs_csi_driver_role"></a> [enable\_aws\_efs\_csi\_driver\_role](#input\_enable\_aws\_efs\_csi\_driver\_role) | Determines whether to install EFS CSI Driver IRSA | `bool` | `false` | no |
| <a name="input_enable_aws_eso_role"></a> [enable\_aws\_eso\_role](#input\_enable\_aws\_eso\_role) | Determines whether to install External Secrets Operator IRSA | `bool` | `false` | no |
| <a name="input_enable_aws_load_balancer_controller_role"></a> [enable\_aws\_load\_balancer\_controller\_role](#input\_enable\_aws\_load\_balancer\_controller\_role) | Determines whether to install AWS Load Balancer Controller IRSA | `bool` | `false` | no |
| <a name="input_enable_cluster_autoscaler_role"></a> [enable\_cluster\_autoscaler\_role](#input\_enable\_cluster\_autoscaler\_role) | Determines whether to install Cluster Autoscaler IRSA | `bool` | `false` | no |
| <a name="input_enable_cluster_creator_admin_permissions"></a> [enable\_cluster\_creator\_admin\_permissions](#input\_enable\_cluster\_creator\_admin\_permissions) | Indicates whether or not to add the cluster creator (the identity used by Terraform) as an administrator via access entry | `bool` | `false` | no |
| <a name="input_eso_iam_role_name"></a> [eso\_iam\_role\_name](#input\_eso\_iam\_role\_name) | The name of the eso IAM role | `string` | `"eso-operator"` | no |
| <a name="input_iam_argo_cd_application_management_role"></a> [iam\_argo\_cd\_application\_management\_role](#input\_iam\_argo\_cd\_application\_management\_role) | ARN of the application management role | `string` | `null` | no |
| <a name="input_iam_argo_cd_cluster_management_role"></a> [iam\_argo\_cd\_cluster\_management\_role](#input\_iam\_argo\_cd\_cluster\_management\_role) | ARN of the cluster management role | `string` | `null` | no |
| <a name="input_kms_key_administrators"></a> [kms\_key\_administrators](#input\_kms\_key\_administrators) | A list of IAM ARNs for [key administrators](https://docs.aws.amazon.com/kms/latest/developerguide/key-policy-default.html#key-policy-default-allow-administrators). The current caller identity is always used to ensure at least one key admin is available | `list(string)` | `[]` | no |
| <a name="input_kms_key_aliases"></a> [kms\_key\_aliases](#input\_kms\_key\_aliases) | A list of aliases to create. Note - due to the use of `toset()`, values must be static strings and not computed values | `list(string)` | `[]` | no |
| <a name="input_nlb_eip_count"></a> [nlb\_eip\_count](#input\_nlb\_eip\_count) | Determines the number of Elastic IPs used on the network load balancer | `number` | `3` | no |
| <a name="input_node_increase_pod_limit"></a> [node\_increase\_pod\_limit](#input\_node\_increase\_pod\_limit) | Determines whether prefix delegation is enabled. | `bool` | `true` | no |
| <a name="input_node_subnet_ids"></a> [node\_subnet\_ids](#input\_node\_subnet\_ids) | A list of default subnet IDs where the `eks_managed_node_groups` will be provisioned. | `list(string)` | `[]` | no |
| <a name="input_pod_subnet_ids"></a> [pod\_subnet\_ids](#input\_pod\_subnet\_ids) | A list of subnet IDs where the pods will be provisioned. If not provided, the pods (ENIs) will be provisioned in the `node_subnet_ids` subnets. | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cluster_certificate_authority_data"></a> [cluster\_certificate\_authority\_data](#output\_cluster\_certificate\_authority\_data) | Base64 encoded certificate data required to communicate with the cluster |
| <a name="output_cluster_endpoint"></a> [cluster\_endpoint](#output\_cluster\_endpoint) | Endpoint for your Kubernetes API server |
| <a name="output_cluster_id"></a> [cluster\_id](#output\_cluster\_id) | The name/id of the EKS cluster. Will block on cluster creation until the cluster is really ready |
| <a name="output_cluster_oidc_issuer_url"></a> [cluster\_oidc\_issuer\_url](#output\_cluster\_oidc\_issuer\_url) | The URL on the EKS cluster for the OpenID Connect identity provider |
<!-- END_TF_DOCS -->

## Docs

To update the docs just run
```shell
$ terraform-docs .
```