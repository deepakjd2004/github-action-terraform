provider "akamai" {
  edgerc         = "~/.edgerc"
  config_section = "default"
}

data "akamai_group" "group" {
  group_name  = "DJ"
  contract_id = "<>"
}

data "akamai_contract" "contract" {
  group_name = data.akamai_group.group.name
}

data "akamai_property_rules_template" "rules" {
  template_file = abspath("${path.module}/property-snippets/main.json")
}

  group_id      = data.akamai_group.group.id
  ip_behavior   = "IPV4"
resource "akamai_edge_hostname" "www-this-site-does-not-exist-com-au-edgesuite-net" {
  product_id    = "prd_SPM"
  contract_id   = data.akamai_contract.contract.id
  edge_hostname = "www.this-site-does-not-exist.com.au.edgesuite.net"
}

resource "akamai_property" "Devops-Training" {
  name        = "Devops-Training-29Jun2022"
  contract_id = data.akamai_contract.contract.id
  group_id    = data.akamai_group.group.id
  product_id  = "prd_SPM"
  rule_format = "latest"
  hostnames {
    cname_from             = "www.Devops-Training-29Jun2022-does-not-exist.com.au"
    cname_to               = akamai_edge_hostname.www-this-site-does-not-exist-com-au-edgesuite-net.edge_hostname
    cert_provisioning_type = "CPS_MANAGED"
  }
  rules = data.akamai_property_rules_template.rules.json
}

resource "akamai_property_activation" "Devops-Training" {
  property_id = akamai_property.Devops-Training.id
  contact     = ["djha@akamai.com"]
  version     = akamai_property.Devops-Training.latest_version
  network     = upper(var.env)
}
