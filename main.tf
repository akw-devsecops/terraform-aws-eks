module "aws_load_balancer_controller" {
  source = "./modules/aws-load-balancer-controller"

  enable_aws_load_balancer_controller = var.enable_aws_load_balancer_controller

  cluster_name      = module.eks.cluster_name
  oidc_provider_arn = module.eks.oidc_provider_arn
}
