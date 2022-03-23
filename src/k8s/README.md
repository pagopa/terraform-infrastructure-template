# kubernetes-infrastructure

This is a kubernetes infrastructure configuration.

## Requirements

### 1. terraform

In order to manage the suitable version of terraform it is strongly recommended to install the following tool:

- [tfenv](https://github.com/tfutils/tfenv): **Terraform** version manager inspired by rbenv.

Once these tools have been installed, install the terraform version shown in:

- .terraform-version

After installation install terraform:

```sh
tfenv install
```

### 2. Azure CLI

In order to authenticate to Azure portal and manage terraform state it's necessary to install and login to Azure subscription.

- [Azure CLI](https://docs.microsoft.com/it-it/cli/azure/install-azure-cli)

After installation login to Azure:

```sh
az login
```

### 3. kubectl

In order to run commands against Kubernetes clusters it's necessary to install kubectl.

- [kubectl](https://kubernetes.io/docs/tasks/tools/)

### 4. helm

In order to use Helm package manager for Kubernetes it's necessary to install helm.

- [helm](https://helm.sh/docs/helm/helm_install/)

### 5. Access to bastian host (jumpbox)

We deploy a kubernetes in private mode so it is not public accessible.
We use an SSH connection to a bastian host started on demand (jumpbox).

```sh
## ~/.ssh/config file configuration
# Change project_aks_env_user, user and bastian_host_env_ip with correct values
# Ask to an Azure Administrator the id_rsa_project_aks_env_user private key
Host project_aks_env_user
  AddKeysToAgent yes
  UseKeychain yes
  HostName bastian_host_env_ip
  User user
  IdentityFile ~/.ssh/id_rsa_project_aks_env_user
```

```sh
# set rw permission to id_rsa_project_aks_env_user key only for current user
chmod 600 ~/.ssh/id_rsa_project_aks_env_user
ssh-add ~/.ssh/id_rsa_project_aks_env_user
# if nedded, restart ssh-agent
eval "$(ssh-agent -s)"
```

## Terraform modules

As PagoPA we build our standard Terraform modules, check available modules:

- [PagoPA Terraform modules](https://github.com/search?q=topic%3Aterraform-modules+org%3Apagopa&type=repositories)

## Setup configuration

Before first use we need to run a setup script to configure `.bastianhost.ini` and download kube config.

```sh
bash scripts/setup.sh ENV-PROJECT

# example for SelfCare project in DEV environment
bash scripts/setup.sh DEV-SelfCare
```

## Apply changes

To apply changes use `terraform.sh` script as follow:

```sh
bash terraform.sh apply|plan|destroy ENV-PROJECT

# example to apply configuration for SelfCare project in DEV environment
bash terraform.sh apply DEV-SelfCare
```

## Terraform lock.hcl

We have both developers who work with your Terraform configuration on their Linux, macOS or Windows workstations and automated systems that apply the configuration while running on Linux.
<https://www.terraform.io/docs/cli/commands/providers/lock.html#specifying-target-platforms>

So we need to specify this in terraform lock providers:

```sh
terraform init

rm .terraform.lock.hcl

terraform providers lock \
  -platform=windows_amd64 \
  -platform=darwin_amd64 \
  -platform=linux_amd64
```

## Precommit checks

Check your code before commit.

<https://github.com/antonbabenko/pre-commit-terraform#how-to-install>

```sh
pre-commit run -a
```
<!-- markdownlint-disable -->
<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >=0.15.3 |
| <a name="requirement_azuread"></a> [azuread](#requirement\_azuread) | = 1.6.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 2.60.0 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | ~> 2.1.2 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | ~> 2.3.2 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azuread"></a> [azuread](#provider\_azuread) | 1.6.0 |
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 2.60.0 |
| <a name="provider_helm"></a> [helm](#provider\_helm) | 2.1.2 |
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | 2.3.2 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_key_vault_secrets_query"></a> [key\_vault\_secrets\_query](#module\_key\_vault\_secrets\_query) | git::https://github.com/pagopa/azurerm.git//key_vault_secrets_query | v1.0.58 |

## Resources

| Name | Type |
|------|------|
| [azurerm_key_vault_secret.azure_devops_sa_cacrt](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_key_vault_secret.azure_devops_sa_token](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [helm_release.ingress](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [kubernetes_cluster_role.cluster_deployer](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/cluster_role) | resource |
| [kubernetes_cluster_role.view_extra](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/cluster_role) | resource |
| [kubernetes_cluster_role_binding.edit_binding](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/cluster_role_binding) | resource |
| [kubernetes_cluster_role_binding.view_binding](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/cluster_role_binding) | resource |
| [kubernetes_cluster_role_binding.view_extra_binding](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/cluster_role_binding) | resource |
| [kubernetes_namespace.selc](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace) | resource |
| [kubernetes_namespace.ingress](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace) | resource |
| [kubernetes_role_binding.deployer_binding](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/role_binding) | resource |
| [kubernetes_secret.azure-storage](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/secret) | resource |
| [kubernetes_secret.selc-application-insights](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/secret) | resource |
| [kubernetes_service_account.azure_devops](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/service_account) | resource |
| [azuread_group.adgroup_contributors](https://registry.terraform.io/providers/hashicorp/azuread/1.6.0/docs/data-sources/group) | data source |
| [azuread_group.adgroup_externals](https://registry.terraform.io/providers/hashicorp/azuread/1.6.0/docs/data-sources/group) | data source |
| [azuread_group.adgroup_security](https://registry.terraform.io/providers/hashicorp/azuread/1.6.0/docs/data-sources/group) | data source |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |
| [azurerm_subscription.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subscription) | data source |
| [kubernetes_secret.azure_devops_secret](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/data-sources/secret) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_env"></a> [env](#input\_env) | n/a | `string` | n/a | yes |
| <a name="input_env_short"></a> [env\_short](#input\_env\_short) | n/a | `string` | n/a | yes |
| <a name="input_ingress_load_balancer_ip"></a> [ingress\_load\_balancer\_ip](#input\_ingress\_load\_balancer\_ip) | n/a | `string` | n/a | yes |
| <a name="input_ingress_replica_count"></a> [ingress\_replica\_count](#input\_ingress\_replica\_count) | n/a | `string` | n/a | yes |
| <a name="input_k8s_apiserver_host"></a> [k8s\_apiserver\_host](#input\_k8s\_apiserver\_host) | n/a | `string` | n/a | yes |
| <a name="input_rbac_namespaces"></a> [rbac\_namespaces](#input\_rbac\_namespaces) | n/a | `list(string)` | n/a | yes |
| <a name="input_default_service_port"></a> [default\_service\_port](#input\_default\_service\_port) | n/a | `number` | `8080` | no |
| <a name="input_event_hub_port"></a> [event\_hub\_port](#input\_event\_hub\_port) | n/a | `number` | `9093` | no |
| <a name="input_k8s_apiserver_insecure"></a> [k8s\_apiserver\_insecure](#input\_k8s\_apiserver\_insecure) | n/a | `bool` | `false` | no |
| <a name="input_k8s_apiserver_port"></a> [k8s\_apiserver\_port](#input\_k8s\_apiserver\_port) | n/a | `number` | `443` | no |
| <a name="input_k8s_kube_config_path"></a> [k8s\_kube\_config\_path](#input\_k8s\_kube\_config\_path) | n/a | `string` | `"~/.kube/config"` | no |
| <a name="input_location"></a> [location](#input\_location) | n/a | `string` | `"westeurope"` | no |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | n/a | `string` | `"selc"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_azure_devops_sa_cacrt"></a> [azure\_devops\_sa\_cacrt](#output\_azure\_devops\_sa\_cacrt) | n/a |
| <a name="output_azure_devops_sa_token"></a> [azure\_devops\_sa\_token](#output\_azure\_devops\_sa\_token) | n/a |
<!-- END_TF_DOCS -->
