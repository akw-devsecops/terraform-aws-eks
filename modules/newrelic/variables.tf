variable "enable_newrelic" {
  description = "Determines whether to install Newrelic for EKS"
  type        = bool
  default     = true
}

variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
}
