data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

resource "aws_vpc" "this" {
  cidr_block = "10.0.0.0/16"

  assign_generated_ipv6_cidr_block = true

  tags = var.tags
}

resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id

  tags = var.tags
}

resource "aws_route_table" "this" {
  vpc_id = aws_vpc.this.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.this.id
  }

  route {
    ipv6_cidr_block = "::/0"
    gateway_id      = aws_internet_gateway.this.id
  }

  tags = var.tags
}

resource "aws_route_table_association" "this" {
  subnet_id      = aws_subnet.this.id
  route_table_id = aws_route_table.this.id
}

resource "aws_subnet" "this" {
  vpc_id = aws_vpc.this.id

  cidr_block                      = "10.0.0.0/24"
  ipv6_cidr_block                 = replace(aws_vpc.this.ipv6_cidr_block, "::/56", "::/64")
  map_public_ip_on_launch         = true
  assign_ipv6_address_on_creation = true

  depends_on = [aws_internet_gateway.this]

  availability_zone = "${data.aws_region.current.name}a"

  tags = var.tags
}

resource "aws_network_interface" "this" {
  subnet_id       = aws_subnet.this.id
  security_groups = [aws_security_group.this.id]

  ipv6_address_count = 1

  tags = var.tags
}

resource "aws_security_group" "this" {
  description = "Allow HTTP and SSH inbound traffic"
  vpc_id      = aws_vpc.this.id

  ingress {
    description      = "SSH"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    description      = "HTTP"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    description      = "HTTPS"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = var.tags
}

resource "aws_eip" "this" {
  domain            = "vpc"
  network_interface = aws_network_interface.this.id
  depends_on        = [aws_internet_gateway.this]
}

