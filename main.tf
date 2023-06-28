module "aws_load_balancer_controller" {
  source = "./modules/aws-load-balancer-controller"

  enable_aws_load_balancer_controller = var.enable_aws_load_balancer_controller

  cluster_name      = module.eks.cluster_name
  oidc_provider_arn = module.eks.oidc_provider_arn
}

module "cert_manager" {
  source = "./modules/cert-manager"

  enable_cert_manager               = var.enable_cert_manager
  enable_cluster_issuer_letsencrypt = var.enable_cluster_issuer_letsencrypt
  cluster_issuer_letsencrypt_email  = var.cluster_issuer_letsencrypt_email
}
