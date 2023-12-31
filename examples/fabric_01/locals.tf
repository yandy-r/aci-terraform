locals {
  fabric_nodes = [{
    annotation  = join(":", ["tag", "leaf101", terraform.workspace])
    description = "Leaf 101 in ${terraform.workspace} environment"
    ext_pool_id = "0"
    fabric_id   = "1"
    name        = "leaf101"
    name_alias  = "leaf101"
    node_id     = "101"
    pod_id      = "1"
    role        = "leaf"
    serial      = "TEP-1-101"
    },
    {
      annotation  = join(":", ["tag", "leaf102", terraform.workspace])
      description = "Leaf 102 in ${terraform.workspace} environment"
      ext_pool_id = "0"
      fabric_id   = "1"
      name        = "leaf102"
      name_alias  = "leaf102"
      node_id     = "102"
      pod_id      = "1"
      role        = "leaf"
      serial      = "TEP-1-102"
    },
    {
      annotation  = join(":", ["tag", "spine103", terraform.workspace])
      description = "Spine 103 in ${terraform.workspace} environment"
      ext_pool_id = "0"
      fabric_id   = "1"
      name        = "spine103"
      name_alias  = "spine103"
      node_id     = "103"
      pod_id      = "1"
      role        = "spine"
      serial      = "TEP-1-103"
    },
    {
      annotation  = join(":", ["tag", "spine104", terraform.workspace])
      description = "Spine 104 in ${terraform.workspace} environment"
      ext_pool_id = "0"
      fabric_id   = "1"
      name        = "spine104"
      name_alias  = "spine104"
      node_id     = "104"
      pod_id      = "1"
      role        = "spine"
      serial      = "TEP-1-104"
  }]

  fabric_wide_settings = [{
    name                        = "fabric_wide_settings"
    disable_ep_dampening        = "yes"
    domain_validation           = "yes"
    enable_remote_leaf_direct   = "yes"
    enforce_subnet_check        = "yes"
    restrict_infra_vlan_traffic = "yes"
    unicast_xr_ep_learn_disable = "yes"
    validate_overlapping_vlans  = "yes"
  }]

  bgp_as_info = {
    asn  = "65000"
    name = "default"
  }

  bgp_rrs = [
    {
      name    = "spine103"
      node_id = 103
      pod_id  = 1
    },
    {
      name    = "spine104"
      node_id = 104
      pod_id  = 1
    }
  ]

  domains = {
    "baremetal" = {
      name        = join("_", ["baremetal", terraform.workspace])
      name_alias  = join("_", ["baremetal", terraform.workspace])
      annotation  = join(":", ["tag", "baremetal", terraform.workspace])
      description = "Physical domain for baremetal domain in ${terraform.workspace} environment"
    }
  }

  vlan_pools = {
    "baremetal" = {
      name        = join("_", ["baremetal", terraform.workspace])
      name_alias  = join("_", ["baremetal", terraform.workspace])
      annotation  = join(":", ["tag", "baremetal", terraform.workspace])
      description = "Vlan pool for baremetal domain in ${terraform.workspace} environment"
      alloc_mode  = "static"
    },
    "vmm" = {
      name        = join("_", ["vmm", terraform.workspace])
      name_alias  = join("_", ["vmm", terraform.workspace])
      annotation  = join(":", ["tag", "vmm", terraform.workspace])
      description = "Vlan pool for vmm domain in ${terraform.workspace} environment"
      alloc_mode  = "dynamic"
    }
  }

  vlan_ranges = {
    "baremetal" = [
      {
        from       = "vlan-100"
        to         = "vlan-199"
        range_role = "external"
        alloc_mode = "static"
      },
      {
        from       = "vlan-300"
        to         = "vlan-399"
        range_role = "external"
        alloc_mode = "static"
      },
    ],
    "vmm" = [
      {
        from       = "vlan-1100"
        to         = "vlan-1199"
        range_role = "external"
        alloc_mode = "inherit"
      },
    ]
  }

  aeeps = {
    "baremetal" = {
      name       = join("_", ["baremetal", terraform.workspace])
      name_alias = join("_", ["baremetal", terraform.workspace])
      annotation = join(":", ["tag", "baremetal", terraform.workspace])
    }

  }
}
