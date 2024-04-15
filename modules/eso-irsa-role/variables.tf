variable "enable_aws_eso_role" {
  description = "Determines whether to install External Secrets Operator IRSA"
  type        = bool
  default     = true
}

variable "oidc_provider_arn" {
  description = "The ARN of the OIDC Provider"
  type        = string
}

variable "iam_role_name" {
  description = "The name of the IAM role"
  type        = string
  default     = "eso-operator"
}
