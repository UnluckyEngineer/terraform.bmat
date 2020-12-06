# VPC
resource "aws_vpc" "new_vpc" {
  cidr_block           = var.cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = merge(var.tags,
    map(
      "Name", "vpc.${var.env}.${var.project_name}",
    )
  )
}

# DHCP
resource "aws_vpc_dhcp_options" "new_vpc-dhcp" {
  domain_name_servers = split(",", var.domain_name_servers)
  depends_on          = [aws_vpc.new_vpc]

  tags = merge(var.tags,
    map(
      "Name", "dhcp.${var.env}.${var.project_name}",
    )
  )
}

# DHCP association
resource "aws_vpc_dhcp_options_association" "new_vpc-dhcp-asso" {
  vpc_id          = aws_vpc.new_vpc.id
  dhcp_options_id = aws_vpc_dhcp_options.new_vpc-dhcp.id
}

# IGW creation
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.new_vpc.id

  tags = merge(var.tags,
    map(
      "Name", "igw.${var.env}.${var.project_name}",
    )
  )
}
