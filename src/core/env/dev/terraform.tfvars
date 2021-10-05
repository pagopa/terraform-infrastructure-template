# general
env_short = "d"

tags = {
  CreatedBy   = "Terraform"
  Environment = "Dev"
  Owner       = "product"
  Source      = "https://github.com/pagopa/product-infra"
  CostCenter  = "TS310 - PAGAMENTI & SERVIZI"
}

lock_enable = false

# networking
cidr_vnet         = ["10.1.0.0/16"]
cidr_subnet_azdoa = ["10.1.130.0/24"]

# dns
external_domain = "pagopa.it"
dns_zone_prefix = "dev.product"

# azure devops
azdo_sp_tls_cert_enabled = false
enable_azdoa             = false
enable_iac_pipeline      = false

# apim


# app_gateway


# postgresql


# apps
