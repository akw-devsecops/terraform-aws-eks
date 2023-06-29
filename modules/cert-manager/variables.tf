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

variable "cluster_issuer_letsencrypt_email" {
  description = "Let's Encrypt will use this to contact you about expiring certificates, and issues related to your account."
  type        = string
  default     = null
}
