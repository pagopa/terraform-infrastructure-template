prefix = "dvopla"

# AKS
aks_private_cluster_enabled = false
aks_num_outbound_ips        = 1
kubernetes_version          = "1.21.9"

# namespace
namespace = "devopslab"

# ingress
nginx_helm_version       = "4.0.17"
ingress_replica_count    = "2"
ingress_load_balancer_ip = "20.67.201.123"

# RBAC
rbac_namespaces_for_deployer_binding = ["devopslab", "helm-template"]

# Gateway
api_gateway_url = "https://api.dev.userregistry.pagopa.it"

# configs/secrets
