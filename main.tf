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

  eni_config = {
    create = true
    region = data.aws_region.current.name
    subnets = { for id, subnet in data.aws_subnet.pods : subnet.availability_zone => {
      id             = id,
      securityGroups = [module.eks.cluster_primary_security_group_id]
    } }
  }

  coredns_tolerations = [
    {
      key    = "node-role.kubernetes.io/control-plane"
      effect = "NoSchedule"
    },
    {
      key      = "CriticalAddonsOnly"
      operator = "Exists"
    },
    {
      key    = "arch"
      value  = "arm64"
      effect = "NoSchedule"
    }
  ]

  corefile = <<EOF
.:53 {
    errors
    health {
      lameduck 5s
    }
    ready
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

  admin_roles = { for id, role in var.admin_roles : role => {
    principal_arn = role
    policy_associations = {
      admin = {
        policy_arn = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"
        access_scope = {
          type = "cluster"
        }
      }
    }
    }
  }

  argo_cd_cluster_management = var.iam_argo_cd_cluster_management_role != null ? {
    cluster_management = {
      principal_arn = module.argo_cd_cluster_management_client[0].role_arn
      policy_associations = {
        admin = {
          policy_arn = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"
          access_scope = {
            type = "cluster"
          }
        }
      }
    }
  } : {}

  argo_cd_application_management = var.iam_argo_cd_application_management_role != null ? {
    application_management = {
      principal_arn = module.argo_cd_application_management_client[0].role_arn
      policy_associations = {
        admin = {
          policy_arn = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"
          access_scope = {
            type = "cluster"
          }
        }
      }
    }
  } : {}
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_name    = var.cluster_name
  cluster_version = var.cluster_version

  # Required as long as this module manages the aws-auth configmap
  enable_cluster_creator_admin_permissions = var.enable_cluster_creator_admin_permissions

  cluster_endpoint_private_access = true
  cluster_endpoint_public_access  = true
  vpc_id                          = var.vpc_id
  control_plane_subnet_ids        = var.control_plane_subnet_ids
  cluster_enabled_log_types       = var.cluster_enabled_log_types

  cluster_addons = {
    kube-proxy = {
      most_recent = true
    }
    vpc-cni = {
      most_recent = true
      configuration_values = jsonencode(merge({
        env = merge(local.prefix_delegation_configuration, local.custom_networking_configuration)
        },
        length(var.pod_subnet_ids) > 0 ? {
          eniConfig = local.eni_config
        } : {}
      ))
    }
    coredns = {
      most_recent = true
      configuration_values = jsonencode({
        corefile    = local.corefile
        tolerations = local.coredns_tolerations
      })
    }
  }

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

  kms_key_enable_default_policy = false
  kms_key_administrators        = concat([data.aws_iam_session_context.current.issuer_arn], var.kms_key_administrators)
  kms_key_aliases               = var.kms_key_aliases

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

  access_entries = merge(
    local.admin_roles,
    local.argo_cd_cluster_management,
    local.argo_cd_application_management,
    var.additional_access_entries,
  )
}

locals {
  taint_effects = {
    NO_SCHEDULE        = "NoSchedule"
    NO_EXECUTE         = "NoExecute"
    PREFER_NO_SCHEDULE = "PreferNoSchedule"
  }

  autoscaling_labels = merge([
    for name, group in module.eks.eks_managed_node_groups : {
      for label_name, label_value in coalesce(group.node_group_labels, {}) : "${name}|label|${label_name}" => {
        autoscaling_group = group.node_group_autoscaling_group_names[0],
        key               = "k8s.io/cluster-autoscaler/node-template/label/${label_name}",
        value             = label_value,
      }
    }
  ]...)

  autoscaling_taints = merge([
    for name, group in module.eks.eks_managed_node_groups : {
      for taint in coalesce(group.node_group_taints, []) : "${name}|taint|${taint.key}" => {
        autoscaling_group = group.node_group_autoscaling_group_names[0],
        key               = "k8s.io/cluster-autoscaler/node-template/taint/${taint.key}"
        value             = "${taint.value}:${local.taint_effects[taint.effect]}"
      }
    }
  ]...)

  autoscaling_tags = merge(local.autoscaling_labels, local.autoscaling_taints)
}

resource "aws_autoscaling_group_tag" "this" {
  for_each = local.autoscaling_tags

  autoscaling_group_name = each.value.autoscaling_group

  tag {
    key   = each.value.key
    value = each.value.value

    propagate_at_launch = false
  }
}
