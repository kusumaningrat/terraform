resource "aws_vpc" "myvpc" {
  count = length(var.vpc_names)

  cidr_block = var.vpc_cidr_blocks[count.index]
  tags = {
    Name = var.vpc_names[count.index]
  }
}

resource "aws_subnet" "subnet-a" {
  count             = 2
  vpc_id            = aws_vpc.myvpc[0].id
  cidr_block        = var.subnet_cidr_blocks[0][count.index]

  tags = {
    Name = var.subnet_names[0][count.index]
  }
}

resource "aws_subnet" "subnet-b" {
  count             = 1
  vpc_id            = aws_vpc.myvpc[1].id
  cidr_block        = var.subnet_cidr_blocks[1][0]

  tags = {
    Name = var.subnet_names[1][0]
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.myvpc[0].id
  tags = {
    Name = "vpc-a-igw"
  }
}

resource "aws_route_table" "subnet-public-rtb" {
  vpc_id = aws_vpc.myvpc[0].id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "subnet-a-public-rtb"
  }
}

resource "aws_route_table" "subnet-private-rtb" {
  count = 2

  vpc_id = count.index == 0 ? aws_vpc.myvpc[0].id : aws_vpc.myvpc[1].id

  route {
    cidr_block = count.index == 0 ? aws_subnet.subnet-b[0].cidr_block : aws_subnet.subnet-a[1].cidr_block
    vpc_peering_connection_id = aws_vpc_peering_connection.peering_vpc_a-b.id
  }

  tags = {
    Name = count.index == 0 ? "subnet-a-private-rtb" : "subnet-b-private-rtb"
  }
}


resource "aws_route_table_association" "subnet-public-rtb-assoc" {
  subnet_id      = aws_subnet.subnet-a[0].id
  route_table_id = aws_route_table.subnet-public-rtb.id
}

resource "aws_route_table_association" "subnet-private-rtb-assoc" {
  count = 2
  subnet_id      = count.index == 0 ? aws_subnet.subnet-a[1].id : aws_subnet.subnet-b[0].id
  route_table_id = count.index == 0 ? aws_route_table.subnet-private-rtb[0].id : aws_route_table.subnet-private-rtb[1].id
}

resource "aws_vpc_peering_connection" "peering_vpc_a-b" {
  peer_vpc_id   = aws_vpc.myvpc[1].id
  vpc_id        = aws_vpc.myvpc[0].id

  auto_accept = true
  tags = {
    Name = "peering_vpc_a-b"
  }
}