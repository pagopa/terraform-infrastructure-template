# terraform-infrastructure-template

Terraform template repository for infrastructures projects

## How to use this template

### Change the template name

In this template we use `devopslab` or `dvopla` to define ours project, but you need to change all the information, to be complaint with your project

Inside:

* src\
  * .env\
    * terraform.tfvars

Change this informations

```ts
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
```

And change all the occurency of `devopslab` of his prefix with yours prefix.

In the folders core, pillar and k8s

Change the occurrence `devopslab` with the name of your project or the name that is better for you.

### Terraform folders name convention

Inside the folder src we have this folders, that contains the terraform files. Here you can find the meaning of the folders

* pillar: contains all the basic infrastructure that must be created before to support other layers, and cannot be destroyed every time.
  * for example we can find the dns, vnet or monitoring
* core: here you can find all the business infrastructure objects, use data to load the objects created in pillar.
* k8s: here you can find the setup of your cluster k8s/aks
  * for example ingress, secrets, rbac or service accounts

## Requirements

### 1. terraform

In order to manage the suitable version of terraform it is strongly recommended to install the following tool:

* [tfenv](https://github.com/tfutils/tfenv): **Terraform** version manager inspired by rbenv.

Once these tools have been installed, install the terraform version shown in:

* .terraform-version

After installation install terraform:

```sh
tfenv install
```

## Terraform modules

As PagoPA we build our standard Terraform modules, check available modules:

* [PagoPA Terraform modules](https://github.com/search?q=topic%3Aterraform-modules+org%3Apagopa&type=repositories)

## Apply changes

To apply changes follow the standard terraform lifecycle once the code in this repository has been changed:

```sh
terraform.sh init [dev|uat|prod]

terraform.sh plan [dev|uat|prod]

terraform.sh apply [dev|uat|prod]
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
  -platform=darwin_arm64 \
  -platform=linux_amd64
```

## Precommit checks

Check your code before commit.

<https://github.com/antonbabenko/pre-commit-terraform#how-to-install>

```sh
pre-commit run -a
```

Install the pre-commit hook globally

```sh
DIR=~/.git-template
git config --global init.templateDir ${DIR}
pre-commit init-templatedir -t pre-commit ${DIR}
```
