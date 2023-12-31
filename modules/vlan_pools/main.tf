terraform {
  required_providers {
    aci = {
      source  = "ciscodevnet/aci"
      version = ">=2.10.1"
    }
  }
}

# create vlan pool
resource "aci_vlan_pool" "this" {
  count       = var.deploy ? 1 : 0
  name        = var.vlan_pool.name
  name_alias  = var.vlan_pool.name_alias
  annotation  = var.vlan_pool.annotation
  description = var.vlan_pool.description
  alloc_mode  = var.vlan_pool.alloc_mode
}

output "vlan_pool_id" {
  value = aci_vlan_pool.this[*].id
}

# # create leaf profile
# resource "aci_leaf_profile" "this" {
#   name        = join("_", [var.vlan_pool_name, terraform.workspace, var.leaf_profile_name])
#   name_alias  = join("_", [var.vlan_pool_name, terraform.workspace, var.leaf_profile_name])
#   annotation  = join(":", ["tag", var.vlan_pool_name, terraform.workspace])
#   description = "Leaf profile for ${var.leaf_profile_name} in ${terraform.workspace} environment"
#   relation_infra_rs_acc_port_p = [
#     aci_leaf_interface_profile.this.id,
#   ]
# }

# # create leaf selector
# resource "aci_leaf_selector" "this" {
#   name                    = join("_", [var.vlan_pool_name, terraform.workspace, var.leaf_profile_name])
#   name_alias              = join("_", [var.vlan_pool_name, terraform.workspace, var.leaf_profile_name])
#   annotation              = join("_", [var.vlan_pool_name, terraform.workspace, var.leaf_profile_name])
#   switch_association_type = "range"
#   leaf_profile_dn         = aci_leaf_profile.this.id
#   description             = "Leaf selector for ${var.leaf_profile_name} in ${terraform.workspace} environment"
# }

# # create node block
# resource "aci_node_block" "this" {
#   switch_association_dn = aci_leaf_selector.this.id
#   annotation            = "leaf_101_102"
#   name                  = "leaf_101_102"
#   name_alias            = "leaf_101_102"
#   description           = "leaf_101_102"
#   from_                 = "101"
#   to_                   = "102"
# }

# # create cdp enabled policy
# resource "aci_cdp_interface_policy" "this" {
#   name        = "cdp_enabled"
#   admin_st    = "enabled"
#   annotation  = "tag:cdp"
#   name_alias  = "cdp_enabled"
#   description = "Enable CDP"
# }

# #  create lldp enabled policy
# resource "aci_lldp_interface_policy" "this" {
#   name        = "lldp_enabled"
#   admin_rx_st = "enabled"
#   admin_tx_st = "enabled"
#   annotation  = "tag:lldp"
#   name_alias  = "lldp_enabled"
#   description = "Enable LLDP"
# }

# # create miscabling protocol interface enabled policy
# resource "aci_miscabling_protocol_interface_policy" "this" {
#   name        = "mcp_enabled"
#   admin_st    = "enabled"
#   annotation  = "tag:mcp"
#   name_alias  = "mcp_enabled"
#   description = "Enable MCP"
# }


# # create leaf access policy group
# resource "aci_leaf_access_port_policy_group" "this" {
#   name                          = "baremetal"
#   description                   = "baremetal"
#   annotation                    = "baremetal"
#   name_alias                    = "baremetal"
#   relation_infra_rs_att_ent_p   = aci_attachable_access_entity_profile.this.id
#   relation_infra_rs_cdp_if_pol  = aci_cdp_interface_policy.this.id
#   relation_infra_rs_lldp_if_pol = aci_lldp_interface_policy.this.id
#   relation_infra_rs_mcp_if_pol  = aci_miscabling_protocol_interface_policy.this.id
# }

# # create leaf interface profile
# resource "aci_leaf_interface_profile" "this" {
#   name        = "baremetal"
#   description = "baremetal"
#   annotation  = "baremetal"
#   name_alias  = "baremetal"
# }

# # create access port selector
# resource "aci_access_port_selector" "this" {
#   leaf_interface_profile_dn      = aci_leaf_interface_profile.this.id
#   name                           = "baremetal"
#   description                    = "baremetal"
#   annotation                     = "baremetal"
#   name_alias                     = "baremetal"
#   access_port_selector_type      = "range"
#   relation_infra_rs_acc_base_grp = aci_leaf_access_port_policy_group.this.id
# }

# # create access port block
# resource "aci_access_port_block" "this" {
#   access_port_selector_dn = aci_access_port_selector.this.id
#   annotation              = "baremetal"
#   name                    = "baremetal"
#   name_alias              = "baremetal"
#   description             = "baremetal"
#   from_card               = "1"
#   from_port               = "1"
#   to_card                 = "1"
#   to_port                 = "10"
# }

# # create aci tenant
# resource "aci_tenant" "engineering" {
#   name        = "engineering"
#   description = "engineering"
#   annotation  = "tag:engineering:${terraform.workspace}"
#   name_alias  = "engineering"
# }
