output "vpc_id" {
    value = aws_vpc.my_vpc.id
}

output "ec2_id" {
    value = aws_instance.app_server.id
}

output "internal_subnet_1_id" {
    value = aws_subnet.my_internal_subnet_1.id
}

output "internal_subnet_2_id" {
    value = aws_subnet.my_internal_subnet_2.id
}

output "public_subnet_1_id" {
    value = aws_subnet.my_public_subnet_1.id
}

output "public_subnet_2_id" {
    value = aws_subnet.my_public_subnet_2.id
}

output "internet_gateway_id" {
    value = aws_internet_gateway.my_igw.id
}

output "security_group_id" {
    value = aws_security_group.my_security_group.id
}

output "public_route_table_1" {
    value = aws_route_table.my_public_route_table.id
}

output "internal_route_table_1" {
    value = aws_route_table.my_internal_route_table.id
}