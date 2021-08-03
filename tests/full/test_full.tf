terraform {
  required_providers {
    test = {
      source = "terraform.io/builtin/test"
    }

    aci = {
      source  = "netascode/aci"
      version = ">=0.2.0"
    }
  }
}

resource "aci_rest" "fvTenant" {
  dn         = "uni/tn-TF"
  class_name = "fvTenant"
}

module "main" {
  source = "../.."

  tenant      = aci_rest.fvTenant.content.name
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

data "aci_rest" "vzFilter" {
  dn = module.main.dn

  depends_on = [module.main]
}

resource "test_assertions" "vzFilter" {
  component = "vzFilter"

  equal "name" {
    description = "name"
    got         = data.aci_rest.vzFilter.content.name
    want        = module.main.name
  }

  equal "nameAlias" {
    description = "nameAlias"
    got         = data.aci_rest.vzFilter.content.nameAlias
    want        = "FILTER1-ALIAS"
  }

  equal "descr" {
    description = "descr"
    got         = data.aci_rest.vzFilter.content.descr
    want        = "My Description"
  }
}

data "aci_rest" "vzEntry" {
  dn = "${data.aci_rest.vzFilter.id}/e-ENTRY1"

  depends_on = [module.main]
}

resource "test_assertions" "vzEntry" {
  component = "vzEntry"

  equal "name" {
    description = "name"
    got         = data.aci_rest.vzEntry.content.name
    want        = "ENTRY1"
  }

  equal "nameAlias" {
    description = "nameAlias"
    got         = data.aci_rest.vzEntry.content.nameAlias
    want        = "ENTRY1-ALIAS"
  }

  equal "descr" {
    description = "descr"
    got         = data.aci_rest.vzEntry.content.descr
    want        = "Entry Description"
  }

  equal "etherT" {
    description = "etherT"
    got         = data.aci_rest.vzEntry.content.etherT
    want        = "ip"
  }

  equal "prot" {
    description = "prot"
    got         = data.aci_rest.vzEntry.content.prot
    want        = "tcp"
  }

  equal "sFromPort" {
    description = "sFromPort"
    got         = data.aci_rest.vzEntry.content.sFromPort
    want        = "123"
  }

  equal "sToPort" {
    description = "sToPort"
    got         = data.aci_rest.vzEntry.content.sToPort
    want        = "124"
  }

  equal "dFromPort" {
    description = "dFromPort"
    got         = data.aci_rest.vzEntry.content.dFromPort
    want        = "234"
  }

  equal "dToPort" {
    description = "dToPort"
    got         = data.aci_rest.vzEntry.content.dToPort
    want        = "235"
  }

  equal "stateful" {
    description = "stateful"
    got         = data.aci_rest.vzEntry.content.stateful
    want        = "yes"
  }
}
