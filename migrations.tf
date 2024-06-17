moved {
  from = module.eks.kubernetes_config_map_v1_data.aws_auth[0]
  to   = module.aws_auth.kubernetes_config_map_v1_data.aws_auth[0]
}
