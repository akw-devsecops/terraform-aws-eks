module "aws_ebs_csi_driver" {
  source = "./modules/aws-ebs-csi-driver"

  enable_aws_ebs_csi_driver_role = var.enable_aws_ebs_csi_driver_role

  oidc_provider_arn = module.eks.oidc_provider_arn
  iam_role_name     = var.ebs_iam_role_name
}

module "aws_efs_csi_driver" {
  source = "./modules/aws-efs-csi-driver"

  enable_aws_efs_csi_driver_role = var.enable_aws_efs_csi_driver_role

  oidc_provider_arn = module.eks.oidc_provider_arn
  iam_role_name     = var.efs_iam_role_name
}

module "aws_load_balancer_controller" {
  source = "./modules/aws-load-balancer-controller"

  enable_aws_load_balancer_controller_role = var.enable_aws_load_balancer_controller_role

  oidc_provider_arn = module.eks.oidc_provider_arn
  iam_role_name     = var.aws_lb_iam_role_name
}

module "cluster_autoscaler" {
  source = "./modules/cluster-autoscaler"

  enable_cluster_autoscaler_role = var.enable_cluster_autoscaler_role

  cluster_name      = module.eks.cluster_name
  oidc_provider_arn = module.eks.oidc_provider_arn
  iam_role_name     = var.cluster_autoscaler_iam_role_name
}

module "nginx" {
  source = "./modules/nginx"

  enable_nginx = var.enable_nginx

  nlb_eip_count = var.nlb_eip_count
}

module "argo_cd_cluster_management_client" {
  source = "./modules/argo-cd-client"

  count = var.iam_argo_cd_cluster_management_role != null ? 1 : 0

  remote_cluster_name = var.argo_cd_cluster_management_cluster_name
  trusted_role_arn    = var.iam_argo_cd_cluster_management_role
}

module "argo_cd_application_management_client" {
  source = "./modules/argo-cd-client"

  count = var.iam_argo_cd_application_management_role != null ? 1 : 0

  remote_cluster_name = var.argo_cd_application_management_cluster_name
  trusted_role_arn    = var.iam_argo_cd_application_management_role
}

module "argo_cd_controller" {
  source = "./modules/argo-cd-controller"

  count = length(var.argo_cd_remote_target_iam_role_arns) > 0 ? 1 : 0

  cluster_name                    = module.eks.cluster_name
  oidc_provider_arn               = module.eks.oidc_provider_arn
  remote_management_iam_role_arns = var.argo_cd_remote_target_iam_role_arns
}

module "eso_irsa_role" {
  source = "./modules/eso-irsa-role"

  enable_aws_eso_role = var.enable_aws_eso_role
  oidc_provider_arn   = module.eks.oidc_provider_arn
  iam_role_name       = var.eso_iam_role_name
}