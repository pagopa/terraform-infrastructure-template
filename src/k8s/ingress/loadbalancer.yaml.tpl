controller:
  service:
    loadBalancerIP: ${load_balancer_ip}
    annotations:
      service.beta.kubernetes.io/azure-load-balancer-internal: ${is_load_balancer_private}
      service.beta.kubernetes.io/azure-load-balancer-resource-group: ${vnet_resource_group_name}
