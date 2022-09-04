resource "aws_vpc" "this" {
    cidr_block = var.vpc_cidr

    enable_dns_hostnames = var.enable_dns_hostnames
    enable_dns_support = var.enable_dns_support

    tags = {
      "Name" = "${var.system_name}-vpc"
    }
}

resource "aws_internet_gateway" "this" {
    vpc_id = aws_vpc.this.id

    tags = {
      "Name" = "${var.system_name}-igw"
    }
}

resource "aws_subnet" "public" {
    count = length(var.public_subnet)

    availability_zone = element(var.azs, count.index)
    cidr_block = element(var.public_subnet, count.index)
    map_public_ip_on_launch = var.map_public_ip_on_launch
    vpc_id = aws_vpc.this.id

    tags = {
      "Name" = "${var.system_name}-public-${count.index+1}"
    }
}

resource "aws_subnet" "private" {
    count = length(var.private_subnet)

    availability_zone = element(var.azs, count.index)
    cidr_block = element(var.private_subnet, count.index)
    map_public_ip_on_launch = false
    vpc_id = aws_vpc.this.id

    tags = {
      "Name" = "${var.system_name}-private-${count.index+1}"
    }
}

resource "aws_route_table" "public" {
    vpc_id = aws_vpc.this.id

    tags = {
      "Name" = "${var.system_name}-public-rtb"
    }
}

resource "aws_route" "internte_gateway_public" {
    destination_cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.this.id
    route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public" {
    count = length(var.public_subnet)

    route_table_id = aws_route_table.public.id
    subnet_id = aws_subnet.public[count.index].id
}

resource "aws_route_table" "private" {
    count = length(var.private_subnet)

    vpc_id = aws_vpc.this.id

    tags = {
      "Name" = "${var.system_name}-private-rtb-${count.index+1}"
    }
}

resource "aws_route" "nat_gateway_private" {
    count = var.enable_nat_gateway ? length(var.azs) : 0

    destination_cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.this[count.index].id 
    route_table_id = aws_route_table.private[count.index].id
}

resource "aws_route_table_association" "private" {
    count = length(var.private_subnet)

    route_table_id = aws_route_table.private[count.index].id
    subnet_id = aws_subnet.private[count.index].id
}

resource "aws_eip" "nat_gateway" {
    count = var.enable_nat_gateway ? length(var.azs) : 0
    vpc = true

    tags = {
      "Name" = "${var.system_name}-nat-gateway"
    }
}

resource "aws_nat_gateway" "this" {
    count = var.enable_nat_gateway ? length(var.public_subnet) : 0

    allocation_id = aws_eip.nat_gateway[count.index].id
    subnet_id = aws_subnet.public[count.index].id
}