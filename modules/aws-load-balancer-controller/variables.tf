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

variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
}

variable "oidc_provider_arn" {
  description = "The ARN of the OIDC Provider"
  type        = string
}
