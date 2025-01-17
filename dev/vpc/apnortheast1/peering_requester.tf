# --- VPC Peering Request Create --- #
# !! A routing table must be created in advance !!
 # request create
resource "aws_vpc_peering_connection" "main_connection" {
    for_each = { for entry in var.vpc_peering_list : entry.peer_vpc_name => entry }
    peer_owner_id = each.value.peer_owner_id
    peer_region   = each.value.peer_region
    peer_vpc_id   = each.value.peer_vpc_id
    vpc_id        = aws_vpc.main.id

    tags = {
        Name = "${var.vpc_name}-with-${each.value.peer_vpc_name}"
    }
}

 # routing add
locals {
    private_svr_peering_route_list = flatten([
        for pair in setproduct(var.vpc_peering_list, aws_route_table.private_svr.*.id) : [
            for cidr in pair[0].peer_vpc_cidr : {
                peer_vpc_name  = pair[0].peer_vpc_name
                peer_vpc_cidr  = cidr
                route_table_id = pair[1]
            }
        ]
    ])
}
             
resource "aws_route" "private_svr_peering" {
    for_each = { for entry in local.private_svr_peering_route_list : "${entry.peer_vpc_name}_${entry.peer_vpc_cidr}_${entry.route_table_id}" => entry }
    route_table_id            = each.value.route_table_id
    destination_cidr_block    = each.value.peer_vpc_cidr
    vpc_peering_connection_id = aws_vpc_peering_connection.main_connection[each.value.peer_vpc_name].id
}

