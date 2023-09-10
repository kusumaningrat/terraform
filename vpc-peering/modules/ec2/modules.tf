resource "aws_security_group" "public-sg" {
  name        = "instance-a-public-sg"
  vpc_id      = element(var.vpc_ids, 0)
  description = "Allow SSH inbound traffic for public instance"

  # Rules of SSH Connection for public instances
  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "private-sg" {
  count       = 2
  name        = count.index == 0 ? "instance-a-private-sg" : "instance-b-private-sg"
  vpc_id      = element(var.vpc_ids, count.index)
  description = count.index == 0 ? "Allow SSH inbound traffic for private a instance" : "Allow SSH inbound traffic for private b instance"

  # Rules of SSH Connection for private instances
  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = count.index == 0 ? [element(var.subnet_cidr_blocks[0], 0)] : [element(var.subnet_cidr_blocks[0], 1)]
  }

  # Rules of ICMP Connection for private instances
  ingress {
    description = "ICMP"
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = count.index == 0 ? [element(var.subnet_cidr_blocks[1], 0)] : [element(var.subnet_cidr_blocks[0], 1)]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "instance-public" {
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name
  security_groups = [aws_security_group.public-sg.id]
  subnet_id     = var.subnet_a_ids[0]

  associate_public_ip_address = true
  
  tags = {
    Name = "instance-a-public"
  }
}

resource "aws_instance" "instance-private" {
  count         = 2
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name
  security_groups = [aws_security_group.private-sg[count.index].id]
  subnet_id     = count.index == 0 ? var.subnet_a_ids[1] : var.subnet_b_ids[0]

  tags = {
    Name = count.index == 0 ? "instance-a-private" : "instance-b-private"
  }
}