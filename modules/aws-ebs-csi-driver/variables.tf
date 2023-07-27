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

variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
}

variable "cluster_version" {
  description = "Kubernetes `<major>.<minor>` version to use for the EKS cluster (i.e.: `1.25`)"
  type        = string
}

variable "oidc_provider_arn" {
  description = "The ARN of the OIDC Provider"
  type        = string
}
