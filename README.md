# Terraform Vultr Matchbox

[![GitHub Release](https://img.shields.io/github/release/celest-io/terraform-vultr-matchbox.svg?style=flat)]()

A terraform module that will create a matchbox configuration for VMs provisioned on Vultr

## Usage

```terraform
module "matchbox_vultr" {
  source                 = "celest-io/matchbox/vultr"
  profile_name           = "k8s-vm"
  ssh_keys               = [vultr_ssh_key.provisioning.ssh_key]
  matchbox_http_endpoint = "http://matchbox.celest.io"
}
```
