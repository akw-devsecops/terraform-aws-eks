variable "aws_region" {
  description = "The AWS region"
  type        = string
}

################################################################################
# Cluster
################################################################################
variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
}

variable "cluster_version" {
  description = "Kubernetes `<major>.<minor>` version to use for the EKS cluster (i.e.: `1.22`)"
  type        = string
}

variable "vpc_id" {
  description = "ID of the VPC where the cluster and its nodes will be provisioned"
  type        = string
}

variable "control_plane_subnet_ids" {
  description = "A list of subnet IDs where the EKS cluster control plane (ENIs) will be provisioned. Used for expanding the pool of subnets used by nodes/node groups without replacing the EKS control plane"
  type        = list(string)
  default     = []
}

variable "node_subnet_ids" {
  description = "A list of default subnet IDs where the `eks_managed_node_groups` will be provisioned."
  type        = list(string)
  default     = []
}

variable "pod_subnet_ids" {
  description = "A list of subnet IDs where the pods will be provisioned. If not provided, the pods (ENIs) will be provisioned in the `node_subnet_ids` subnets."
  type        = list(string)
  default     = []
}

variable "eks_managed_node_groups" {
  description = "Map of EKS managed node group definitions to create"
  type        = any
  default     = {}
}

variable "node_increase_pod_limit" {
  description = "Determines whether prefix delegation is enabled."
  type        = bool
  default     = true
}

variable "default_pod_security_policy" {
  description = "Configures the default pod security policy. Valid values are privileged, baseline or restricted."
  type        = string
  default     = "baseline"
}

variable "kms_key_aliases" {
  description = "A list of aliases to create. Note - due to the use of `toset()`, values must be static strings and not computed values"
  type        = list(string)
  default     = []
}



################################################################################
# aws-auth configmap
################################################################################
variable "iam_admin_role" {
  description = "ARN of the admin role that will be added to `system:masters`"
  type        = string
}

variable "iam_argo_cd_cluster_management_role" {
  description = "ARN of the cluster management role"
  type        = string
  default     = null
}

variable "iam_argo_cd_application_management_role" {
  description = "ARN of the application management role"
  type        = string
  default     = null
}

variable "iam_additional_roles" {
  description = "List of additional roles maps to add to the aws-auth configmap"
  type        = list(any)
  default     = []
}

variable "iam_additional_users" {
  description = "List of additional user maps to add to the aws-auth configmap"
  type        = list(any)
  default     = []
}

################################################################################
# Addons
################################################################################
variable "enable_metrics_server" {
  description = "Determines whether to install Metrics Server for EKS"
  type        = bool
  default     = true
}

variable "enable_cluster_autoscaler" {
  description = "Determines whether to install Cluster Autoscaler for EKS"
  type        = bool
  default     = true
}

variable "enable_cluster_autoscaler_role" {
  description = "Determines whether to install Cluster Autoscaler IRSA"
  type        = bool
  default     = true
}

variable "enable_aws_load_balancer_controller" {
  description = "Determines whether to install AWS Load Balancer Controller for EKS"
  type        = bool
  default     = true
}

variable "enable_aws_load_balancer_controller_role" {
  description = "Determines whether to install AWS Load Balancer Controller IRSA"
  type        = bool
  default     = true
}

variable "enable_cert_manager" {
  description = "Determines whether to install Cert Manager for EKS"
  type        = bool
  default     = true
}

variable "enable_cluster_issuer_letsencrypt" {
  description = "Determines whether to create the LetsEncrypt ClusterIssuer. Can only work when Cert Manager is already set up"
  type        = bool
  default     = true
}

variable "enable_calico" {
  description = "Determines whether to install Calico for EKS"
  type        = bool
  default     = true
}

variable "enable_nginx" {
  description = "Determines whether to install NGINX Ingress Controller for EKS"
  type        = bool
  default     = true
}

variable "enable_newrelic" {
  description = "Determines whether to install Newrelic for EKS"
  type        = bool
  default     = true
}

variable "enable_aws_ebs_csi_driver" {
  description = "Determines whether to install EBS CSI Driver for EKS"
  type        = bool
  default     = true
}

variable "enable_aws_ebs_csi_driver_role" {
  description = "Determines whether to install EBS CSI Driver IRSA"
  type        = bool
  default     = true
}

variable "enable_aws_efs_csi_driver" {
  description = "Determines whether to install EFS CSI Driver for EKS"
  type        = bool
  default     = false
}

variable "enable_aws_efs_csi_driver_role" {
  description = "Determines whether to install EFS CSI Driver IRSA"
  type        = bool
  default     = false
}

variable "enable_aws_eso_role" {
  description = "Determines whether to install External Secrets Operator IRSA"
  type        = bool
  default     = false
}

################################################################################
# Addon config
################################################################################
variable "nlb_eip_count" {
  description = "Determines the number of Elastic IPs used on the network load balancer"
  type        = number
  default     = 3
}

variable "cluster_issuer_letsencrypt_email" {
  description = "Let's Encrypt will use this to contact you about expiring certificates, and issues related to your account."
  type        = string
  default     = null
}

variable "coredns_additional_zones" {
  description = "Additional zones to be placed in CoreDNS Corefile."
  type        = string
  default     = ""
}

variable "ebs_iam_role_name" {
  description = "The name of the ebs-csi IAM role"
  type        = string
  default     = "ebs-csi"
}

variable "efs_iam_role_name" {
  description = "The name of the efs-csi IAM role"
  type        = string
  default     = "efs-csi"
}

variable "aws_lb_iam_role_name" {
  description = "The name of the aws-load-balancer-controller IAM role"
  type        = string
  default     = "aws-load-balancer-controller"
}

variable "cluster_autoscaler_iam_role_name" {
  description = "The name of the cluster-autoscaler IAM role"
  type        = string
  default     = "cluster-autoscaler"
}

variable "eso_iam_role_name" {
  description = "The name of the eso IAM role"
  type        = string
  default     = "eso-operator"
}

variable "argo_cd_cluster_management_cluster_name" {
  description = "The name of the cluster management cluster"
  type        = string
  default     = ""
}

variable "argo_cd_application_management_cluster_name" {
  description = "The name of the application management cluster"
  type        = string
  default     = ""
}

variable "argo_cd_remote_target_iam_role_arns" {
  description = "The name of the IAM roles to assume for remote cluster management"
  type        = set(string)
  default     = []
}
