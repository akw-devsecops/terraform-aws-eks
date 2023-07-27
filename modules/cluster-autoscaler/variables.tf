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

variable "aws_region" {
  description = "The AWS region"
  type        = string
}

variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
}

variable "cluster_version" {
  description = "Kubernetes `<major>.<minor>` version to use for the EKS cluster (i.e.: `1.22`)"
  type        = string
}

variable "oidc_provider_arn" {
  description = "The ARN of the OIDC Provider"
  type        = string
}
