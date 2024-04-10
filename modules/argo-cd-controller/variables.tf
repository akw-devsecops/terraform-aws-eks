variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
}

variable "oidc_provider_arn" {
  description = "The ARN of the OIDC Provider"
  type        = string
}

variable "remote_management_iam_role_arns" {
  description = "The name of the IAM roles to assume for remote cluster management"
  type        = set(string)
  default     = []
}

variable "argo_eso_iam_role_name" {
  description = "The name of the IAM role to access secrets via ESO"
  type        = string
  default     = "argocd-controller-eso"
}
