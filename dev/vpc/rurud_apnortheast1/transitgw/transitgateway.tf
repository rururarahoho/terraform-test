## --- Transit Gateway --- ##
 # trasit gateway create
resource "aws_ec2_transit_gateway" "main_tgw" {
    description = "Transit Gateway of ${var.aws_region} region"
    default_route_table_association = "disable"
    default_route_table_propagation = "disable"

    tags = {
        Name = "${var.shard_id}-tgw"
    }
}

 # tgw <-> vpc attachment
resource "aws_ec2_transit_gateway_vpc_attachment" "main_vpc" {
  subnet_ids         = aws_subnet.private_svr.*.id
  transit_gateway_id = aws_ec2_transit_gateway.main_tgw.id
  vpc_id             = aws_vpc.main.id

  tags = {
    Name = "${var.shard_id}-tgw-${var.vpc_name}"
  }
}

 # route table create
resource "aws_ec2_transit_gateway_route_table" "main_vpc_rt" {
  transit_gateway_id = aws_ec2_transit_gateway.main_tgw.id
  
  tags = {
    Name = "${var.shard_id}-tgw-${var.vpc_name}-rt"
  }
}
 
  # route table association
resource "aws_ec2_transit_gateway_route_table_association" "main_vpc_rt_as" {
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.main_vpc.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.main_vpc_rt.id
}

 # route table routing
resource "aws_ec2_transit_gateway_route" "main_sub_vpc" {
  destination_cidr_block         = "10.30.0.0/16"
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.main_vpc.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.main_vpc_rt.id
}