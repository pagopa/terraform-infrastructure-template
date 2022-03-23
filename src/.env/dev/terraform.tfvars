# general
env_short      = "d"
env            = "dev"
prefix         = "dvopla"
location       = "northeurope"
location_short = "neu"

tags = {
  CreatedBy   = "Terraform"
  Environment = "DEV"
  Owner       = "DevOps"
  Source      = "https://github.com/pagopa/devopslab-infra"
  CostCenter  = "TS310 - PAGAMENTI & SERVIZI"
}

lock_enable = false

# 🔐 key vault
key_vault_name    = "dvopla-d-neu-kv"
key_vault_rg_name = "dvopla-d-sec-rg"

# ☁️ networking
cidr_vnet              = ["10.1.0.0/16"]
cidr_subnet_appgateway = ["10.1.128.0/24"]
cidr_subnet_postgres   = ["10.1.129.0/24"]
cidr_subnet_azdoa      = ["10.1.130.0/24"]
cidr_subnet_apim       = ["10.1.136.0/24"]
cidr_subnet_app_docker = ["10.1.137.0/24"]
cidr_subnet_bastion    = ["10.1.138.0/24"]
cidr_subnet_k8s        = ["10.1.0.0/17"]

# dns
prod_dns_zone_prefix = "devopslab"
lab_dns_zone_prefix  = "lab.devopslab"
external_domain      = "pagopa.it"

# azure devops
enable_azdoa        = true
enable_iac_pipeline = true

# app_gateway
app_gateway_sku_name             = "Standard_v2"
app_gateway_sku_tier             = "Standard_v2"
app_gateway_alerts_enabled       = false
app_gateway_waf_enabled          = false
app_gateway_api_certificate_name = "api-devopslab-pagopa-it"

# postgres
postgres_private_endpoint_enabled      = false
postgres_sku_name                      = "B_Gen5_1"
postgres_public_network_access_enabled = false
postgres_network_rules = {
  ip_rules = [
    "0.0.0.0/0"
  ]
  # dblink
  allow_access_to_azure_services = false
}

#
# 🗺 APIM
#
apim_publisher_name                = "PagoPA DevOpsLab LAB"
apim_sku                           = "Developer_1"
apim_api_internal_certificate_name = "api-internal-devopslab-pagopa-it"



#
# ⛴ AKS
#
aks_private_cluster_enabled = false
aks_alerts_enabled          = false
# This is the k8s ingress controller ip. It must be in the aks subnet range.
reverse_proxy_ip        = "10.1.0.250"
aks_max_pods            = 100
aks_enable_auto_scaling = false
aks_node_min_count      = null
aks_node_max_count      = null
aks_vm_size             = "Standard_B2ms"
