module "aws_ebs_csi_driver" {
  source = "./modules/aws-ebs-csi-driver"

  enable_aws_ebs_csi_driver      = var.enable_aws_ebs_csi_driver
  enable_aws_ebs_csi_driver_role = var.enable_aws_ebs_csi_driver_role

  cluster_name      = module.eks.cluster_name
  cluster_version   = module.eks.cluster_version
  oidc_provider_arn = module.eks.oidc_provider_arn
}

module "aws_efs_csi_driver" {
  source = "./modules/aws-efs-csi-driver"

  enable_aws_efs_csi_driver      = var.enable_aws_efs_csi_driver
  enable_aws_efs_csi_driver_role = var.enable_aws_efs_csi_driver_role

  oidc_provider_arn = module.eks.oidc_provider_arn
}

module "aws_load_balancer_controller" {
  source = "./modules/aws-load-balancer-controller"

  enable_aws_load_balancer_controller      = var.enable_aws_load_balancer_controller
  enable_aws_load_balancer_controller_role = var.enable_aws_load_balancer_controller_role

  cluster_name      = module.eks.cluster_name
  oidc_provider_arn = module.eks.oidc_provider_arn
}

module "calico" {
  source = "./modules/calico"

  enable_calico = var.enable_calico
}

module "cert_manager" {
  source = "./modules/cert-manager"

  enable_cert_manager = var.enable_cert_manager

  enable_cluster_issuer_letsencrypt = var.enable_cluster_issuer_letsencrypt
  cluster_issuer_letsencrypt_email  = var.cluster_issuer_letsencrypt_email
}

module "cluster_autoscaler" {
  source = "./modules/cluster-autoscaler"

  enable_cluster_autoscaler      = var.enable_cluster_autoscaler
  enable_cluster_autoscaler_role = var.enable_cluster_autoscaler_role

  aws_region        = var.aws_region
  cluster_name      = module.eks.cluster_name
  cluster_version   = module.eks.cluster_version
  oidc_provider_arn = module.eks.oidc_provider_arn
}

module "metrics_server" {
  source = "./modules/metrics-server"

  enable_metrics_server = var.enable_metrics_server
}

module "newrelic" {
  source = "./modules/newrelic"

  enable_newrelic = var.enable_newrelic

  cluster_name = module.eks.cluster_name
}

module "nginx" {
  source = "./modules/nginx"

  enable_nginx = var.enable_nginx

  nlb_eip_count = var.nlb_eip_count
}
