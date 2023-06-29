variable "enable_nginx" {
  description = "Determines whether to install NGINX Ingress Controller for EKS"
  type        = bool
  default     = true
}

variable "nlb_eip_count" {
  description = "Determines the number of Elastic IPs used on the network load balancer"
  type        = number
  default     = 3
}
