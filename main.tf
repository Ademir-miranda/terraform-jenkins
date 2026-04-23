provider "aws" {
  region = "us-east-2"
}

data "aws_ami" "amazon_linux" {
  most_recent = true

  owners = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-*-arm64"]
  }
}

resource "aws_security_group" "ssh_novo" {
  name        = "allow_ssh_terraform_v2"
  description = "Permitir SSH"
  vpc_id      = "vpc-01b2eb67443367412"

  ingress {
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

resource "aws_instance" "exemplo" {
  ami           = data.aws_ami.amazon_linux.id
  instance_type = "t4g.small"
  key_name      = "ubuntu"

  vpc_security_group_ids = ["sg-0fd9d5e9224bb3d05"]

  tags = {
    Name = "exemplo-terraform"
  }
}
