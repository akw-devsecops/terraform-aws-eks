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

variable "kms_key_aliases" {
  description = "A list of aliases to create. Note - due to the use of `toset()`, values must be static strings and not computed values"
  type        = list(string)
  default     = []
}

variable "kms_key_administrators" {
  description = "A list of IAM ARNs for [key administrators](https://docs.aws.amazon.com/kms/latest/developerguide/key-policy-default.html#key-policy-default-allow-administrators). The current caller identity is always used to ensure at least one key admin is available"
  type        = list(string)
  default     = []
}

variable "enable_cluster_creator_admin_permissions" {
  description = "Indicates whether or not to add the cluster creator (the identity used by Terraform) as an administrator via access entry"
  type        = bool
  default     = false
}

variable "admin_roles" {
  description = "ARN of the admin roles that will be added as AmazonEKSClusterAdminPolicy"
  type        = set(string)
}

variable "additional_access_entries" {
  description = "Map of access entries to add to the cluster"
  type        = any
  default     = {}
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

variable "cluster_enabled_log_types" {
  description = "A list of the desired control plane logs to enable. For more information, see Amazon EKS Control Plane Logging documentation (https://docs.aws.amazon.com/eks/latest/userguide/control-plane-logs.html)"
  type        = list(string)
  default     = []
}

variable "cluster_support_type" {
  description = "The support type for the cluster. Can be either `STANDARD` or `EXTENDED`"
  type        = string
  default     = "STANDARD"
}

################################################################################
# Addons
################################################################################
variable "enable_cluster_autoscaler_role" {
  description = "Determines whether to install Cluster Autoscaler IRSA"
  type        = bool
  default     = false
}

variable "enable_aws_load_balancer_controller_role" {
  description = "Determines whether to install AWS Load Balancer Controller IRSA"
  type        = bool
  default     = false
}

variable "enable_aws_ebs_csi_driver_role" {
  description = "Determines whether to install EBS CSI Driver IRSA"
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
