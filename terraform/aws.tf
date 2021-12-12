resource "aws_security_group" "consul-sg" {
  name        = "consul-sg"
  description = "Allow ssh, consul and tcp inbound traffic"
  vpc_id      = aws_vpc.consul_vpc.id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    self        = true
    description = "Allow all inside security group"
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow ssh from the world"
  }

  ingress {
    from_port   = 8500
    to_port     = 8500
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow consul UI access from the world"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow all outside security group"
  }
}

resource "tls_private_key" "opsschool_consul_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "opsschool_consul_key" {
  key_name   = "opsschool_consul_key"
  public_key = tls_private_key.opsschool_consul_key.public_key_openssh
}

resource "null_resource" "chmod_400_key" {
  provisioner "local-exec" {
    command = "chmod 400 ${path.module}/${local_file.private_key.filename}"
  }
}

resource "local_file" "private_key" {
  sensitive_content = tls_private_key.opsschool_consul_key.private_key_pem
  filename          = var.pem_key_name
}
