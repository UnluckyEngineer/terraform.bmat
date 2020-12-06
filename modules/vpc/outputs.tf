output "vpc_id" {
  value = aws_vpc.new_vpc.id
}

output "gw_id" {
  value = aws_internet_gateway.gw.id
}

output "main_route_table_id" {
  value = aws_vpc.new_vpc.main_route_table_id
}
