variable "remote_cluster_name" {
  description = "The name management cluster"
  type        = string
}

variable "trusted_role_arn" {
  description = "ARN of AWS entity who can assume this role"
  type        = string
}
