# general
env_short = "p"

tags = {
  CreatedBy   = "Terraform"
  Environment = "Prod"
  Owner       = "product"
  Source      = "https://github.com/pagopa/product-infra"
  CostCenter  = "TS310 - PAGAMENTI & SERVIZI"
}

lock_enable = true

# networking
cidr_vnet         = ["10.1.0.0/16"]
cidr_subnet_azdoa = ["10.1.130.0/24"]

# dns
external_domain = "pagopa.it"
dns_zone_prefix = "product"

# azure devops
azdo_sp_tls_cert_enabled = false
enable_azdoa             = false
enable_iac_pipeline      = false

# apim


# app_gateway


# postgresql


# apps
