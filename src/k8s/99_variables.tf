variable "location" {
  type    = string
  default = "westeurope"
}

variable "prefix" {
  type = string
}

variable "env" {
  type = string
}

variable "env_short" {
  type = string
}

#
# 🔐 Key Vault
#
variable "key_vault_name" {
  type        = string
  description = "Key Vault name"
  default     = ""
}

variable "key_vault_rg_name" {
  type        = string
  default     = ""
  description = "Key Vault - rg name"
}

#
# namespace
#
variable "namespace" {
  type        = string
  description = "name of namespace for application"
}

#
# ⛴ AKS
#
variable "aks_private_cluster_enabled" {
  type        = bool
  description = "Enable or not public visibility of AKS"
}

variable "aks_num_outbound_ips" {
  type        = number
  description = "Number of public outbound ips"
}

#
# ⛴ K8s
#

variable "k8s_kube_config_path_prefix" {
  type    = string
  default = "~/.kube"
}

# variable "k8s_apiserver_host" {
#   type = string
# }

variable "k8s_apiserver_port" {
  type    = number
  default = 443
}

variable "k8s_apiserver_insecure" {
  type    = bool
  default = false
}

variable "rbac_namespaces_for_deployer_binding" {
  type        = list(string)
  description = "Namespaces where to apply deployer binding rules"
}

# ingress

variable "ingress_replica_count" {
  type = string
}

variable "ingress_load_balancer_ip" {
  type = string
}

variable "default_service_port" {
  type    = number
  default = 8080
}

variable "nginx_helm_version" {
  type        = string
  description = "NGINX helm verison"
}

# # gateway
# variable "api_gateway_url" {
#   type = string
# }


# # configs/secrets

#
# 🀄️ LOCALS
#
locals {
  project = "${var.prefix}-${var.env_short}"

  #VNET
  vnet_resource_group_name = "${local.project}-vnet-rg"
  aks_public_ip_name       = "${local.project}-aksoutbound-pip"
  aks_public_ip_index_name = "${local.aks_public_ip_name}-${var.aks_num_outbound_ips}"

  # AKS
  aks_rg_name      = "${local.project}-aks-rg"
  aks_cluster_name = "${local.project}-aks"
}
