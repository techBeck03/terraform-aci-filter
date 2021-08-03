resource "aci_rest" "vzFilter" {
  dn         = "uni/tn-${var.tenant}/flt-${var.name}"
  class_name = "vzFilter"
  content = {
    name      = var.name
    nameAlias = var.alias
    descr     = var.description
  }
}

resource "aci_rest" "vzEntry" {
  for_each   = { for entry in var.entries : entry.name => entry }
  dn         = "${aci_rest.vzFilter.id}/e-${each.value.name}"
  class_name = "vzEntry"
  content = {
    name      = each.value.name
    nameAlias = each.value.alias != null ? each.value.alias : ""
    descr     = each.value.description != null ? each.value.description : ""
    etherT    = each.value.ethertype != null ? each.value.ethertype : "ip"
    prot      = contains(["ip", "ipv4", "ipv6", null], each.value.ethertype) ? (each.value.protocol != null ? each.value.protocol : "tcp") : null
    sFromPort = each.value.source_from_port != null ? each.value.source_from_port : "unspecified"
    sToPort   = each.value.source_to_port != null ? each.value.source_to_port : "unspecified"
    dFromPort = each.value.destination_from_port != null ? each.value.destination_from_port : "unspecified"
    dToPort   = each.value.destination_to_port != null ? each.value.destination_to_port : "unspecified"
    stateful  = each.value.stateful == true ? "yes" : "no"
  }
}
