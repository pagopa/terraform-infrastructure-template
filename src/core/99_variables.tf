# general

variable "prefix" {
  type = string
  validation {
    condition = (
      length(var.prefix) <= 6
    )
    error_message = "Max length is 6 chars."
  }
}

variable "env" {
  type = string
  validation {
    condition = (
      length(var.env) <= 3
    )
    error_message = "Max length is 3 chars."
  }
}

variable "env_short" {
  type = string
  validation {
    condition = (
      length(var.env_short) <= 1
    )
    error_message = "Max length is 1 chars."
  }
}

variable "location" {
  type    = string
  default = "westeurope"
}

variable "location_short" {
  type        = string
  description = "Location short like eg: neu, weu.."
}

variable "lock_enable" {
  type        = bool
  default     = false
  description = "Apply locks to block accedentaly deletions."
}

variable "tags" {
  type = map(any)
  default = {
    CreatedBy = "Terraform"
  }
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

# ☁️ network
variable "cidr_vnet" {
  type        = list(string)
  description = "Virtual network address space."
}

## Appgateway: Network
variable "cidr_subnet_appgateway" {
  type        = list(string)
  description = "Application gateway address space."
}

variable "cidr_subnet_azdoa" {
  type        = list(string)
  description = "Azure DevOps agent network address space."
}

variable "cidr_subnet_apim" {
  type        = list(string)
  description = "Address prefixes subnet api management."
  default     = null
}

variable "cidr_subnet_k8s" {
  type        = list(string)
  description = "Subnet cluster kubernetes."
}

variable "cidr_subnet_app_docker" {
  type        = list(string)
  description = "Subnet web app docker."
}

variable "cidr_subnet_bastion" {
  type        = list(string)
  description = "Subnet bastion vm."
}

#
# 📇 dns
#
variable "dns_default_ttl_sec" {
  type        = number
  description = "value"
  default     = 3600
}

variable "external_domain" {
  type        = string
  default     = null
  description = "Domain for delegation"
}

variable "prod_dns_zone_prefix" {
  type        = string
  default     = null
  description = "The dns subdomain."
}

variable "lab_dns_zone_prefix" {
  type        = string
  default     = null
  description = "The dns subdomain."
}

# ❇️ app gateway
variable "app_gateway_sku_name" {
  type        = string
  description = "SKU Name of the App GW"
  default     = "Standard_v2"
}

variable "app_gateway_sku_tier" {
  type        = string
  description = "SKU tier of the App GW"
  default     = "Standard_v2"
}

variable "app_gateway_alerts_enabled" {
  type        = bool
  description = "Enable alerts"
  default     = false
}

variable "app_gateway_waf_enabled" {
  type        = bool
  description = "Enable WAF"
  default     = false
}

## appgateway: Scaling

variable "app_gateway_min_capacity" {
  type    = number
  default = 0
}

variable "app_gateway_max_capacity" {
  type    = number
  default = 2
}

variable "app_gateway_api_certificate_name" {
  type        = string
  description = "Application gateway api certificate name on Key Vault"
}

# # 🚀 azure devops
# variable "enable_azdoa" {
#   type        = bool
#   description = "Enable Azure DevOps agent."
# }

# variable "enable_iac_pipeline" {
#   type        = bool
#   description = "If true create the key vault policy to allow used by azure devops iac pipelines."
#   default     = false
# }

#
# 🗺 APIM
#

variable "apim_publisher_name" {
  type        = string
  default     = ""
  description = "Apim publisher name"
}

variable "apim_sku" {
  type        = string
  default     = "Developer_1"
  description = "APIM SKU type"
}

variable "apim_api_internal_certificate_name" {
  type        = string
  description = "KeyVault certificate name"
}

#
# ⛴ AKS
#
variable "aks_private_cluster_enabled" {
  type        = bool
  description = "Enable or not public visibility of AKS"
  default     = false
}

variable "aks_num_outbound_ips" {
  type        = number
  default     = 1
  description = "How many outbound ips allocate for AKS cluster"
}

variable "aks_availability_zones" {
  type        = list(number)
  description = "A list of Availability Zones across which the Node Pool should be spread."
  default     = []
}

variable "aks_vm_size" {
  type        = string
  default     = "Standard_DS3_v2"
  description = "The size of the AKS Virtual Machine in the Node Pool."
}

variable "aks_max_pods" {
  type        = number
  description = "The maximum number of pods"
  default     = 100
}

variable "aks_enable_auto_scaling" {
  type        = bool
  description = "Should the Kubernetes Auto Scaler be enabled for this Node Pool? "
  default     = false
}

variable "aks_node_count" {
  type        = number
  description = "The initial number of the AKS nodes which should exist in this Node Pool."
  default     = 1
}

variable "aks_node_min_count" {
  type        = number
  description = "The minimum number of nodes which should exist in this Node Pool. If specified this must be between 1 and 1000"
  default     = null
}

variable "aks_node_max_count" {
  type        = number
  description = "The maximum number of nodes which should exist in this Node Pool. If specified this must be between 1 and 1000"
  default     = null
}

variable "kubernetes_version" {
  type        = string
  description = "Kubernetes version of cluster aks"
}

variable "aks_sku_tier" {
  type        = string
  description = "The SKU Tier that should be used for this Kubernetes Cluster."
  default     = "Free"
}

variable "reverse_proxy_ip" {
  type        = string
  default     = "127.0.0.1"
  description = "AKS external ip. Also the ingress-nginx-controller external ip. Value known after installing the ingress controller."
}

variable "aks_metric_alerts" {
  description = <<EOD
Map of name = criteria objects
EOD

  type = map(object({
    # criteria.*.aggregation to be one of [Average Count Minimum Maximum Total]
    aggregation = string
    # "Insights.Container/pods" "Insights.Container/nodes"
    metric_namespace = string
    metric_name      = string
    # criteria.0.operator to be one of [Equals NotEquals GreaterThan GreaterThanOrEqual LessThan LessThanOrEqual]
    operator  = string
    threshold = number
    # Possible values are PT1M, PT5M, PT15M, PT30M and PT1H
    frequency = string
    # Possible values are PT1M, PT5M, PT15M, PT30M, PT1H, PT6H, PT12H and P1D.
    window_size = string

    dimension = list(object(
      {
        name     = string
        operator = string
        values   = list(string)
      }
    ))
  }))

  default = {
    node_cpu = {
      aggregation      = "Average"
      metric_namespace = "Insights.Container/nodes"
      metric_name      = "cpuUsagePercentage"
      operator         = "GreaterThan"
      threshold        = 80
      frequency        = "PT1M"
      window_size      = "PT5M"
      dimension = [
        {
          name     = "host"
          operator = "Include"
          values   = ["*"]
        }
      ],
    }
    node_memory = {
      aggregation      = "Average"
      metric_namespace = "Insights.Container/nodes"
      metric_name      = "memoryWorkingSetPercentage"
      operator         = "GreaterThan"
      threshold        = 80
      frequency        = "PT1M"
      window_size      = "PT5M"
      dimension = [
        {
          name     = "host"
          operator = "Include"
          values   = ["*"]
        }
      ],
    }
    node_disk = {
      aggregation      = "Average"
      metric_namespace = "Insights.Container/nodes"
      metric_name      = "DiskUsedPercentage"
      operator         = "GreaterThan"
      threshold        = 80
      frequency        = "PT1M"
      window_size      = "PT5M"
      dimension = [
        {
          name     = "host"
          operator = "Include"
          values   = ["*"]
        },
        {
          name     = "device"
          operator = "Include"
          values   = ["*"]
        }
      ],
    }
    node_not_ready = {
      aggregation      = "Average"
      metric_namespace = "Insights.Container/nodes"
      metric_name      = "nodesCount"
      operator         = "GreaterThan"
      threshold        = 0
      frequency        = "PT1M"
      window_size      = "PT5M"
      dimension = [
        {
          name     = "status"
          operator = "Include"
          values   = ["NotReady"]
        }
      ],
    }
    pods_failed = {
      aggregation      = "Average"
      metric_namespace = "Insights.Container/pods"
      metric_name      = "podCount"
      operator         = "GreaterThan"
      threshold        = 0
      frequency        = "PT1M"
      window_size      = "PT5M"
      dimension = [
        {
          name     = "phase"
          operator = "Include"
          values   = ["Failed"]
        }
      ]
    }
    pods_ready = {
      aggregation      = "Average"
      metric_namespace = "Insights.Container/pods"
      metric_name      = "PodReadyPercentage"
      operator         = "LessThan"
      threshold        = 80
      frequency        = "PT1M"
      window_size      = "PT5M"
      dimension = [
        {
          name     = "kubernetes namespace"
          operator = "Include"
          values   = ["*"]
        },
        {
          name     = "controllerName"
          operator = "Include"
          values   = ["*"]
        }
      ]
    }
    container_cpu = {
      aggregation      = "Average"
      metric_namespace = "Insights.Container/containers"
      metric_name      = "cpuExceededPercentage"
      operator         = "GreaterThan"
      threshold        = 95
      frequency        = "PT1M"
      window_size      = "PT5M"
      dimension = [
        {
          name     = "kubernetes namespace"
          operator = "Include"
          values   = ["*"]
        },
        {
          name     = "controllerName"
          operator = "Include"
          values   = ["*"]
        }
      ]
    }
    container_memory = {
      aggregation      = "Average"
      metric_namespace = "Insights.Container/containers"
      metric_name      = "memoryWorkingSetExceededPercentage"
      operator         = "GreaterThan"
      threshold        = 95
      frequency        = "PT1M"
      window_size      = "PT5M"
      dimension = [
        {
          name     = "kubernetes namespace"
          operator = "Include"
          values   = ["*"]
        },
        {
          name     = "controllerName"
          operator = "Include"
          values   = ["*"]
        }
      ]
    }
    container_oom = {
      aggregation      = "Average"
      metric_namespace = "Insights.Container/pods"
      metric_name      = "oomKilledContainerCount"
      operator         = "GreaterThan"
      threshold        = 0
      frequency        = "PT1M"
      window_size      = "PT1M"
      dimension = [
        {
          name     = "kubernetes namespace"
          operator = "Include"
          values   = ["*"]
        },
        {
          name     = "controllerName"
          operator = "Include"
          values   = ["*"]
        }
      ]
    }
    container_restart = {
      aggregation      = "Average"
      metric_namespace = "Insights.Container/pods"
      metric_name      = "restartingContainerCount"
      operator         = "GreaterThan"
      threshold        = 0
      frequency        = "PT1M"
      window_size      = "PT1M"
      dimension = [
        {
          name     = "kubernetes namespace"
          operator = "Include"
          values   = ["*"]
        },
        {
          name     = "controllerName"
          operator = "Include"
          values   = ["*"]
        }
      ]
    }
  }
}

variable "aks_alerts_enabled" {
  type        = bool
  default     = true
  description = "Aks alert enabled?"
}

#
# Locals
#
locals {
  project = "${var.prefix}-${var.env_short}"

  # VNET
  vnet_resource_group_name = "${local.project}-vnet-rg"
  vnet_name                = "${local.project}-vnet"

  appgateway_public_ip_name = "${local.project}-gw-pip"
  bastion_public_ip_name    = "${local.project}-bastion-pip"

  # api.internal.*.devopslab.pagopa.it
  api_internal_domain = "api.internal.${var.prod_dns_zone_prefix}.${var.external_domain}"

  # ACR DOCKER
  docker_rg_name       = "${local.project}-dockerreg-rg"
  docker_registry_name = replace("${var.prefix}-${var.env_short}-${var.location_short}-acr", "-", "")

  # AKS
  aks_rg_name              = "${local.project}-aks-rg"
  aks_cluster_name         = "${local.project}-aks"
  aks_public_ip_name       = "${local.project}-aksoutbound-pip"
  aks_public_ip_index_name = "${local.aks_public_ip_name}-${var.aks_num_outbound_ips}"

  # monitor
  monitor_rg_name                      = "${local.project}-monitor-rg"
  monitor_log_analytics_workspace_name = "${local.project}-law"
  monitor_appinsights_name             = "${local.project}-appinsights"

  monitor_action_group_slack_name = "SlackPagoPA"
  monitor_action_group_email_name = "PagoPA"
}
