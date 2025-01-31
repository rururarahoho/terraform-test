
# --- VPC Peering Accepter --- #
# !! A routing table must be created in advance !!
 # accepter create
resource "aws_vpc_peering_connection_accepter" "peering_accepter" {
  for_each                  = { for entry in var.vpc_peering_accept_list : entry.peer_id => entry }
  vpc_peering_connection_id = each.value.peer_id
  auto_accept               = true
  tags = {
    Name = "${var.vpc_name}-with-${each.value.peer_vpc_name}"
  }

  lifecycle {
    ignore_changes = [tags]
  }
}

 # routing add
locals {
  private_ws_subnet_peerings = flatten([
    for pair in setproduct(aws_route_table.private_ws.*.id, var.vpc_peering_accept_list) : [
        for cidr in pair[1].peer_cidr_block : {
                route_table_id = pair[0]
                cidr_block     = cidr
                vpc_name       = pair[1].peer_vpc_name
                peering_id     = pair[1].peer_id
            }
        ]
    ])
}

resource "aws_route" "private_ws_peering" {
  for_each                  = { for entry in local.private_ws_subnet_peerings : "${entry.vpc_name}_${entry.route_table_id}_${entry.cidr_block}" => entry }
  route_table_id            = each.value.route_table_id
  destination_cidr_block    = each.value.cidr_block
  vpc_peering_connection_id = each.value.peering_id
}
