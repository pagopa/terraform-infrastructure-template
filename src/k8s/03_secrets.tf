# module "key_vault_secrets_query" {
#   source = "git::https://github.com/pagopa/azurerm.git//key_vault_secrets_query?ref=v1.0.58"

#   resource_group = local.key_vault_resource_group
#   key_vault_name = local.key_vault_name

#   secrets = [
#     "appinsights-instrumentation-key",
#     "redis-primary-access-key",
#     "jwt-private-key",
#     "jwt-public-key",
#     "agid-spid-cert",
#     "agid-spid-private-key",
#     "mongodb-connection-string",
#     "postgres-party-user-password",
#     "postgres-attribute-registry-user-password",
#     "smtp-usr",
#     "smtp-psw",
#     "contracts-storage-access-key",
#     "web-storage-connection-string"
#   ]
# }
