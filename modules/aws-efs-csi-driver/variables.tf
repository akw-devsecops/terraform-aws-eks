variable "enable_aws_efs_csi_driver" {
  description = "Determines whether to install EFS CSI Driver for EKS"
  type        = bool
  default     = true
}

variable "enable_aws_efs_csi_driver_role" {
  description = "Determines whether to install EFS CSI Driver IRSA"
  type        = bool
  default     = true
}

variable "oidc_provider_arn" {
  description = "The ARN of the OIDC Provider"
  type        = string
}
