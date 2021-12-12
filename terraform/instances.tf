
resource "aws_instance" "consul_server" {
  count                       = var.num_consul_servers
  ami                         = data.aws_ami.ubuntu-18.id
  instance_type               = "t2.micro"
  key_name                    = aws_key_pair.opsschool_consul_key.key_name
  subnet_id                   = aws_subnet.public.id
  iam_instance_profile        = aws_iam_instance_profile.consul-join.name
  associate_public_ip_address = true

  vpc_security_group_ids = [aws_security_group.consul-server-sg.id]

  tags = {
    Name          = "opsschool-consul-server-${count.index}"
    consul_server = "true"
  }

}

resource "aws_instance" "consul_agent" {
  count                       = var.num_consul_agents
  ami                         = data.aws_ami.ubuntu-18.id
  instance_type               = "t2.micro"
  key_name                    = aws_key_pair.opsschool_consul_key.key_name
  subnet_id                   = aws_subnet.public.id
  associate_public_ip_address = true
  iam_instance_profile        = aws_iam_instance_profile.consul-join.name
  vpc_security_group_ids      = [aws_security_group.consul-agent-sg.id]

  tags = {
    Name         = "opsschool-consul-agent-${count.index}"
    consul_agent = "true"
  }
}

output "server" {
  value = aws_instance.consul_server.*.public_ip
}

output "agent" {
  value = aws_instance.consul_agent.*.public_ip
}

