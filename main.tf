locals {
  prefix_delegation_configuration = var.node_increase_pod_limit ? {
    ENABLE_PREFIX_DELEGATION = "true"
    WARM_IP_TARGET           = 5
    MINIMUM_IP_TARGET        = 2
  } : {}

  custom_networking_configuration = length(var.pod_subnet_ids) > 0 ? {
    AWS_VPC_K8S_CNI_CUSTOM_NETWORK_CFG = "true"
    ENI_CONFIG_LABEL_DEF               = "topology.kubernetes.io/zone"
  } : {}

  admin_role_map = [{
    rolearn  = var.iam_admin_role
    username = "admin"
    groups   = ["system:masters"]
  }]

  cluster_management_role_map = var.iam_cluster_management_role != null ? [{
    rolearn  = module.argo_cd_cluster_management_client[0].role_arn
    username = "remote_cluster_management"
    groups   = ["system:masters"]
  }] : []

  application_management_role_map = var.iam_application_management_role != null ? [{
    rolearn  = module.argo_cd_application_management_client[0].role_arn
    username = "remote_application_management"
    groups   = ["system:masters"]
  }] : []

  corefile = <<EOF
.:53 {
    errors
    health
    kubernetes cluster.local in-addr.arpa ip6.arpa {
      pods insecure
      fallthrough in-addr.arpa ip6.arpa
    }
    prometheus :9153
    forward . /etc/resolv.conf
    cache 30
    loop
    reload
    loadbalance
}
${var.coredns_additional_zones}
EOF

}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 19.0"

  cluster_name    = var.cluster_name
  cluster_version = var.cluster_version

  cluster_endpoint_private_access = true
  cluster_endpoint_public_access  = true

  cluster_addons = {
    kube-proxy = {
      most_recent = true
    }
    vpc-cni = {
      most_recent = true
      configuration_values = jsonencode({
        env = merge(local.prefix_delegation_configuration, local.custom_networking_configuration)
      })
    }
    coredns = {
      most_recent = true
      configuration_values = jsonencode({
        corefile = local.corefile
      })
    }
  }

  vpc_id                   = var.vpc_id
  control_plane_subnet_ids = var.control_plane_subnet_ids

  eks_managed_node_group_defaults = {
    attach_cluster_primary_security_group = true
    subnet_ids                            = var.node_subnet_ids

    block_device_mappings = {
      xvda = {
        device_name = "/dev/xvda"
        ebs = {
          volume_size = 20
          volume_type = "gp3"
        }
      }
    }
  }

  eks_managed_node_groups = var.eks_managed_node_groups

  node_security_group_tags = {
    "kubernetes.io/cluster/${var.cluster_name}" = null
  }

  cluster_security_group_additional_rules = {
    ingress_nodes_ephemeral_ports_tcp = {
      description                = "Nodes on ephemeral ports"
      protocol                   = "tcp"
      from_port                  = 1025
      to_port                    = 65535
      type                       = "ingress"
      source_node_security_group = true
    }
  }

  node_security_group_additional_rules = {
    ingress_self_all = {
      description = "Node to node all ports/protocols"
      protocol    = "-1"
      from_port   = 0
      to_port     = 0
      type        = "ingress"
      self        = true
    }
  }

  manage_aws_auth_configmap = true

  aws_auth_roles = concat(
    local.admin_role_map,
    local.cluster_management_role_map,
    local.application_management_role_map,
    var.iam_additional_roles
  )

  aws_auth_users = var.iam_additional_users
}

data "aws_subnet" "pods" {
  for_each = toset(var.pod_subnet_ids)

  id = each.key
}

resource "kubernetes_manifest" "eni_configs" {
  for_each = data.aws_subnet.pods

  manifest = {
    apiVersion = "crd.k8s.amazonaws.com/v1alpha1"
    kind       = "ENIConfig"
    metadata = {
      name = each.value.availability_zone
    }
    spec = {
      securityGroups = [module.eks.cluster_primary_security_group_id]
      subnet         = each.value.id
    }
  }
}
