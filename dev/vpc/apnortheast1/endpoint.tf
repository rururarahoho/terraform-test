## --- endpoint --- ##
# s3
resource "aws_vpc_endpoint" "s3" {
    vpc_id = aws_vpc.main.id
    service_name = "com.amazonaws.${var.aws_region}.s3"
    vpc_endpoint_type = "Gateway"
    tags = {
        Name = "${var.vpc_name}-endpoint-s3"
    }
}

# routing s3
resource "aws_vpc_endpoint_route_table_association" "private_svr_s3" {
    route_table_id = aws_route_table.private_svr.id
    vpc_endpoint_id = aws_vpc_endpoint.s3.id
}

resource "aws_vpc_endpoint_route_table_association" "private_ws_s3" {
    route_table_id = aws_route_table.private_ws.id
    vpc_endpoint_id = aws_vpc_endpoint.s3.id
}

resource "aws_vpc_endpoint_route_table_association" "private_rd_s3" {
    route_table_id = aws_route_table.private_rd.id
    vpc_endpoint_id = aws_vpc_endpoint.s3.id
}

# dynamodb
resource "aws_vpc_endpoint" "dynamodb" {
    vpc_id = aws_vpc.main.id
    service_name = "com.amazonaws.${var.aws_region}.dynamodb"
    vpc_endpoint_type = "Gateway"
    tags = {
        Name = "${var.vpc_name}-endpoint-dynamodb"
    }
}

# routing dynamodb
resource "aws_vpc_endpoint_route_table_association" "private_svr_dynamodb" {
    route_table_id = aws_route_table.private_svr.id
    vpc_endpoint_id = aws_vpc_endpoint.dynamodb.id
}

resource "aws_vpc_endpoint_route_table_association" "private_ws_dynamodb" {
    route_table_id = aws_route_table.private_ws.id
    vpc_endpoint_id = aws_vpc_endpoint.dynamodb.id
}

resource "aws_vpc_endpoint_route_table_association" "private_rd_dynamodb" {
    route_table_id = aws_route_table.private_rd.id
    vpc_endpoint_id = aws_vpc_endpoint.dynamodb.id
}

# ec2
resource "aws_vpc_endpoint" "ec2" {
    vpc_id = aws_vpc.main.id
    service_name = "com.amazonaws.${var.aws_region}.ec2"
    vpc_endpoint_type = "Interface"
    security_group_ids = [
        aws_security_group.endpoint_default.id
    ]

    private_dns_enabled = true

    subnet_ids = aws_subnet.private_svr.*.id

    tags = {
        Name = "${var.vpc_name}-endpoint-ec2"
    }
}