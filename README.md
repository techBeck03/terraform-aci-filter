<!-- BEGIN_TF_DOCS -->
[![Tests](https://github.com/netascode/terraform-aci-filter/actions/workflows/test.yml/badge.svg)](https://github.com/netascode/terraform-aci-filter/actions/workflows/test.yml)

# Terraform ACI Filter Module

Manages ACI Filter

Location in GUI:
`Tenants` » `XXX` » `Contracts` » `Filters`

## Examples

```hcl
module "aci_filter" {
  source  = "netascode/filter/aci"
  version = ">= 0.0.1"

  tenant      = "ABC"
  name        = "FILTER1"
  alias       = "FILTER1-ALIAS"
  description = "My Description"
  entries = [{
    name                  = "ENTRY1"
    alias                 = "ENTRY1-ALIAS"
    description           = "Entry Description"
    ethertype             = "ip"
    protocol              = "tcp"
    source_from_port      = "123"
    source_to_port        = "124"
    destination_from_port = "234"
    destination_to_port   = "235"
    stateful              = true
  }]
}

```

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_aci"></a> [aci](#requirement\_aci) | >= 0.2.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aci"></a> [aci](#provider\_aci) | >= 0.2.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_tenant"></a> [tenant](#input\_tenant) | Tenant name. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | Filter name. | `string` | n/a | yes |
| <a name="input_alias"></a> [alias](#input\_alias) | Filter alias. | `string` | `""` | no |
| <a name="input_description"></a> [description](#input\_description) | Filter description. | `string` | `""` | no |
| <a name="input_entries"></a> [entries](#input\_entries) | List of filter entries. Choices `ethertype`: `unspecified`, `ipv4`, `trill`, `arp`, `ipv6`, `mpls_ucast`, `mac_security`, `fcoe`, `ip`. Default value `ethertype`: `ip`. Allowed values `protocol`: `unspecified`, `icmp`, `igmp`, `tcp`, `egp`, `igp`, `udp`, `icmpv6`, `eigrp`, `ospfigp`, `pim`, `l2tp` or a number between 0 and 255. Default value `protocol`: `tcp`. Allowed values `source_from_port`, `source_to_port`, `destination_from_port`, `destination_to_port`: `unspecified`, `ftpData`, `smtp`, `dns`, `http`, `pop3`, `https`, `rtsp` or a number between 0 and 65535. Default value `source_from_port`, `source_to_port`, `destination_from_port`, `destination_to_port`: `unspecified`. Default value `stateful`: false. | <pre>list(object({<br>    name                  = string<br>    alias                 = optional(string)<br>    description           = optional(string)<br>    ethertype             = optional(string)<br>    protocol              = optional(string)<br>    source_from_port      = optional(string)<br>    source_to_port        = optional(string)<br>    destination_from_port = optional(string)<br>    destination_to_port   = optional(string)<br>    stateful              = optional(bool)<br>  }))</pre> | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_dn"></a> [dn](#output\_dn) | Distinguished name of `vzFilter` object. |
| <a name="output_name"></a> [name](#output\_name) | Filter name. |

## Resources

| Name | Type |
|------|------|
| [aci_rest.vzEntry](https://registry.terraform.io/providers/netascode/aci/latest/docs/resources/rest) | resource |
| [aci_rest.vzFilter](https://registry.terraform.io/providers/netascode/aci/latest/docs/resources/rest) | resource |
<!-- END_TF_DOCS -->