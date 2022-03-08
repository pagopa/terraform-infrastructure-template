##############
## Products ##
##############

module "apim_product_devopslab" {
  source = "git::https://github.com/pagopa/azurerm.git//api_management_product?ref=v2.2.0"

  product_id   = "devopslab"
  display_name = "DevOpsLab Product"
  description  = "Product for DevOpsLab backend"

  api_management_name = module.apim.name
  resource_group_name = module.apim.resource_group_name

  published             = true
  subscription_required = true
  approval_required     = false

  policy_xml = file("./api_product/devopslab/_base_policy.xml")
}


##############
##   APIs   ##
##############

### webapp-python-alpha

locals {
  apim_devopslab_webapp_python_alpha_api = {
    # params for all api versions
    display_name          = "Webapp Python Alpha api"
    description           = "Webapp Python Alpha api"
    path                  = "webapp-python-alpha"
    subscription_required = false
    service_url           = "http://${data.azurerm_public_ip.aks_pip.ip_address}/webapp-python-alpha"
    api_name    = "${var.env}-webapp-python-alpha-api"
  }
}

# resource "azurerm_api_management_api_version_set" "apim_devopslab_webapp_python_alpha_api" {
#   name                = local.apim_devopslab_webapp_python_alpha_api.api_name
#   resource_group_name = module.apim.resource_group_name
#   api_management_name = module.apim.name
#   display_name        = local.apim_devopslab_webapp_python_alpha_api.display_name
#   versioning_scheme   = "Segment"
# }

module "apim_devopslab_webapp_python_alpha_api_v1" {
  source = "git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v2.2.0"

  name                  = local.apim_devopslab_webapp_python_alpha_api.api_name
  api_management_name   = module.apim.name
  product_ids           = [module.apim_product_devopslab.product_id]
  subscription_required = local.apim_devopslab_webapp_python_alpha_api.subscription_required
  # version_set_id        = azurerm_api_management_api_version_set.apim_devopslab_webapp_python_alpha_api.id
  # api_version           = "v1"
  service_url           = "${local.apim_devopslab_webapp_python_alpha_api.service_url}/"
  resource_group_name   = module.apim.resource_group_name

  description  = local.apim_devopslab_webapp_python_alpha_api.description
  display_name = local.apim_devopslab_webapp_python_alpha_api.display_name
  path         = local.apim_devopslab_webapp_python_alpha_api.path
  protocols    = ["https"]

  content_format = "openapi"
  content_value = templatefile("./api/devopslab/webapp-python/openapi_webapp_python.json.tftpl", {
    projectName = local.apim_devopslab_webapp_python_alpha_api.display_name
  })

  xml_content = file("./api/devopslab/webapp-python/_base_policy.xml")
}

### webapp-python-beta

locals {
  apim_devopslab_webapp_python_beta_api = {
    # params for all api versions
    display_name          = "Webapp Python beta api"
    description           = "Webapp Python beta api"
    path                  = "webapp-python-beta"
    subscription_required = false
    service_url           = "http://${data.azurerm_public_ip.aks_pip.ip_address}/webapp-python-beta"
    api_name    = "${var.env}-webapp-python-beta-api"
  }
}

# resource "azurerm_api_management_api_version_set" "apim_devopslab_webapp_python_beta_api" {
#   name                = local.apim_devopslab_webapp_python_beta_api.api_name
#   resource_group_name = module.apim.resource_group_name
#   api_management_name = module.apim.name
#   display_name        = local.apim_devopslab_webapp_python_beta_api.display_name
#   versioning_scheme   = "Segment"
# }

module "apim_devopslab_webapp_python_beta_api_v1" {
  source = "git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v2.2.0"

  name                  = local.apim_devopslab_webapp_python_beta_api.api_name
  api_management_name   = module.apim.name
  product_ids           = [module.apim_product_devopslab.product_id]
  subscription_required = local.apim_devopslab_webapp_python_beta_api.subscription_required
  # version_set_id        = azurerm_api_management_api_version_set.apim_devopslab_webapp_python_beta_api.id
  # api_version           = "v1"
  service_url           = "${local.apim_devopslab_webapp_python_beta_api.service_url}/"
  resource_group_name   = module.apim.resource_group_name

  description  = local.apim_devopslab_webapp_python_beta_api.description
  display_name = local.apim_devopslab_webapp_python_beta_api.display_name
  path         = local.apim_devopslab_webapp_python_beta_api.path
  protocols    = ["https"]

  content_format = "openapi"
  content_value = templatefile("./api/devopslab/webapp-python/openapi_webapp_python.json.tftpl", {
    projectName = local.apim_devopslab_webapp_python_beta_api.display_name
  })

  xml_content = file("./api/devopslab/webapp-python/_base_policy.xml")
}

### webapp-python-proxy

locals {
  apim_devopslab_webapp_python_proxy_api = {
    # params for all api versions
    display_name          = "Webapp Python proxy api"
    description           = "Webapp Python proxy api"
    path                  = "webapp-python-proxy"
    subscription_required = false
    service_url           = "http://${data.azurerm_public_ip.aks_pip.ip_address}/webapp-python-proxy"
    api_name    = "${var.env}-webapp-python-proxy-api"
  }
}

# resource "azurerm_api_management_api_version_set" "apim_devopslab_webapp_python_proxy_api" {
#   name                = local.apim_devopslab_webapp_python_proxy_api.api_name
#   resource_group_name = module.apim.resource_group_name
#   api_management_name = module.apim.name
#   display_name        = local.apim_devopslab_webapp_python_proxy_api.display_name
#   versioning_scheme   = "Segment"
# }

module "apim_devopslab_webapp_python_proxy_api_v1" {
  source = "git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v2.2.0"

  name                  = local.apim_devopslab_webapp_python_proxy_api.api_name
  api_management_name   = module.apim.name
  product_ids           = [module.apim_product_devopslab.product_id]
  subscription_required = local.apim_devopslab_webapp_python_proxy_api.subscription_required
  # version_set_id        = azurerm_api_management_api_version_set.apim_devopslab_webapp_python_proxy_api.id
  # api_version           = "v1"
  service_url           = "${local.apim_devopslab_webapp_python_proxy_api.service_url}/"
  resource_group_name   = module.apim.resource_group_name

  description  = local.apim_devopslab_webapp_python_proxy_api.description
  display_name = local.apim_devopslab_webapp_python_proxy_api.display_name
  path         = local.apim_devopslab_webapp_python_proxy_api.path
  protocols    = ["https"]

  content_format = "openapi"
  content_value = templatefile("./api/devopslab/webapp-python-proxy/openapi_webapp_python.json.tftpl", {
    projectName = local.apim_devopslab_webapp_python_proxy_api.display_name
  })

  xml_content = file("./api/devopslab/webapp-python-proxy/_base_policy.xml")
}
