# output "azure_devops_sa_token" {
#   value     = data.kubernetes_secret.azure_devops_secret.binary_data["token"]
#   sensitive = true
# }

# output "azure_devops_sa_cacrt" {
#   value     = data.kubernetes_secret.azure_devops_secret.binary_data["ca.crt"]
#   sensitive = true
# }

output "aks_fqdn" {
  value = data.azurerm_kubernetes_cluster.aks_cluster.fqdn
}
