# AWS EKS Module

Terraform Module to set up an AWS EKS cluster. 

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.47 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | >= 2.0 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | >= 2.10 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 4.47 |
| <a name="provider_helm"></a> [helm](#provider\_helm) | >= 2.0 |
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | >= 2.10 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_aws_ebs_csi_driver"></a> [aws\_ebs\_csi\_driver](#module\_aws\_ebs\_csi\_driver) | ./modules/aws-ebs-csi-driver | n/a |
| <a name="module_aws_efs_csi_driver"></a> [aws\_efs\_csi\_driver](#module\_aws\_efs\_csi\_driver) | ./modules/aws-efs-csi-driver | n/a |
| <a name="module_aws_load_balancer_controller"></a> [aws\_load\_balancer\_controller](#module\_aws\_load\_balancer\_controller) | ./modules/aws-load-balancer-controller | n/a |
| <a name="module_calico"></a> [calico](#module\_calico) | ./modules/calico | n/a |
| <a name="module_cert_manager"></a> [cert\_manager](#module\_cert\_manager) | ./modules/cert-manager | n/a |
| <a name="module_cluster_autoscaler_irsa_role"></a> [cluster\_autoscaler\_irsa\_role](#module\_cluster\_autoscaler\_irsa\_role) | terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks | ~> 5.0 |
| <a name="module_eks"></a> [eks](#module\_eks) | terraform-aws-modules/eks/aws | ~> 19.0 |

## Resources

| Name | Type |
|------|------|
| [aws_eip.nlb_ips](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip) | resource |
| [helm_release.cluster_autoscaler](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [helm_release.ingress_nginx](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [helm_release.metrics_server](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [helm_release.newrelic_bundle](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [kubernetes_manifest.eni_configs](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/manifest) | resource |
| [aws_ssm_parameter.newrelic_license_key](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ssm_parameter) | data source |
| [aws_subnet.pods](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnet) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | The AWS region | `string` | n/a | yes |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | Name of the EKS cluster | `string` | n/a | yes |
| <a name="input_cluster_version"></a> [cluster\_version](#input\_cluster\_version) | Kubernetes `<major>.<minor>` version to use for the EKS cluster (i.e.: `1.22`) | `string` | n/a | yes |
| <a name="input_iam_admin_role"></a> [iam\_admin\_role](#input\_iam\_admin\_role) | ARN of the admin role that will be added to `system:masters` | `string` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | ID of the VPC where the cluster and its nodes will be provisioned | `string` | n/a | yes |
| <a name="input_cluster_issuer_letsencrypt_email"></a> [cluster\_issuer\_letsencrypt\_email](#input\_cluster\_issuer\_letsencrypt\_email) | Let's Encrypt will use this to contact you about expiring certificates, and issues related to your account. | `string` | `null` | no |
| <a name="input_control_plane_subnet_ids"></a> [control\_plane\_subnet\_ids](#input\_control\_plane\_subnet\_ids) | A list of subnet IDs where the EKS cluster control plane (ENIs) will be provisioned. Used for expanding the pool of subnets used by nodes/node groups without replacing the EKS control plane | `list(string)` | `[]` | no |
| <a name="input_default_pod_security_policy"></a> [default\_pod\_security\_policy](#input\_default\_pod\_security\_policy) | Configures the default pod security policy. Valid values are privileged, baseline or restricted. | `string` | `"baseline"` | no |
| <a name="input_eks_managed_node_groups"></a> [eks\_managed\_node\_groups](#input\_eks\_managed\_node\_groups) | Map of EKS managed node group definitions to create | `any` | `{}` | no |
| <a name="input_enable_aws_ebs_csi_driver"></a> [enable\_aws\_ebs\_csi\_driver](#input\_enable\_aws\_ebs\_csi\_driver) | Determines whether to install EBS CSI Driver for EKS | `bool` | `true` | no |
| <a name="input_enable_aws_efs_csi_driver"></a> [enable\_aws\_efs\_csi\_driver](#input\_enable\_aws\_efs\_csi\_driver) | Determines whether to install EFS CSI Driver for EKS | `bool` | `false` | no |
| <a name="input_enable_aws_load_balancer_controller"></a> [enable\_aws\_load\_balancer\_controller](#input\_enable\_aws\_load\_balancer\_controller) | Determines whether to install AWS Load Balancer Controller for EKS | `bool` | `true` | no |
| <a name="input_enable_calico"></a> [enable\_calico](#input\_enable\_calico) | Determines whether to install Calico for EKS | `bool` | `true` | no |
| <a name="input_enable_cert_manager"></a> [enable\_cert\_manager](#input\_enable\_cert\_manager) | Determines whether to install Cert Manager for EKS | `bool` | `true` | no |
| <a name="input_enable_cluster_autoscaler"></a> [enable\_cluster\_autoscaler](#input\_enable\_cluster\_autoscaler) | Determines whether to install Cluster Autoscaler for EKS | `bool` | `true` | no |
| <a name="input_enable_cluster_issuer_letsencrypt"></a> [enable\_cluster\_issuer\_letsencrypt](#input\_enable\_cluster\_issuer\_letsencrypt) | Determines whether to create the LetsEncrypt ClusterIssuer. Can only work when Cert Manager is already set up | `bool` | `true` | no |
| <a name="input_enable_metrics_server"></a> [enable\_metrics\_server](#input\_enable\_metrics\_server) | Determines whether to install Metrics Server for EKS | `bool` | `true` | no |
| <a name="input_enable_newrelic"></a> [enable\_newrelic](#input\_enable\_newrelic) | Determines whether to install Newrelic for EKS | `bool` | `true` | no |
| <a name="input_enable_nginx"></a> [enable\_nginx](#input\_enable\_nginx) | Determines whether to install NGINX Ingress Controller for EKS | `bool` | `true` | no |
| <a name="input_iam_additional_roles"></a> [iam\_additional\_roles](#input\_iam\_additional\_roles) | List of additional roles maps to add to the aws-auth configmap | `list(any)` | `[]` | no |
| <a name="input_iam_additional_users"></a> [iam\_additional\_users](#input\_iam\_additional\_users) | List of additional user maps to add to the aws-auth configmap | `list(any)` | `[]` | no |
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