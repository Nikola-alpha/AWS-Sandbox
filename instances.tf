###create tls_keys####
resource "tls_private_key" "ec2-alpha_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}
resource "aws_key_pair" "gen_key" {
  key_name   = "my-gen-key"
  public_key = tls_private_key.ec2-alpha_key.public_key_openssh
}
resource "local_file" "alpha_key" {
  content  = tls_private_key.ec2-alpha_key.private_key_pem
  filename = "${path.module}/alpha1.pem"
}

###create two security groups###
###bastion_sg###
resource "aws_security_group" "bastion_sg" {
  name        = "bastion_sg"
  description = "Allow SSH inbound traffic"
  vpc_id      = aws_vpc.main.id

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
###private-sg###
resource "aws_security_group" "private_sg" {
  name        = "private_sg"
  description = "Allow SSH inbound traffic from bastion host"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.bastion_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

###create two ec2 instances###
###bastion-host###
###create eip first###

resource "aws_instance" "bastion_host" {
  ami                    = var.instance-ami
  instance_type          = var.instance-type
  key_name               = aws_key_pair.gen_key.key_name
  availability_zone      = "ap-southeast-1b"
  subnet_id              = aws_subnet.public-subnet-1b.id
  vpc_security_group_ids = [aws_security_group.bastion_sg.id]

  associate_public_ip_address = false
    tags = {
    Name = "bastion_host"
  }

}
# Elastic IP for bastion host
resource "aws_eip" "bastion_eip" {
  instance = aws_instance.bastion_host.id
  domain = "vpc"
  tags = {
    Name = "bastion_eip"
  }
}
resource "null_resource" "configure_ssh" {
  depends_on = [aws_instance.bastion_host, aws_eip.bastion_eip]

  provisioner "file" {
    source      = local_file.alpha_key.filename
    destination = "/home/ec2-user/.ssh/alpha1.pem"

    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = tls_private_key.ec2-alpha_key.private_key_pem
      host        = aws_eip.bastion_eip.public_ip
    }
  }
  provisioner "file" {
    source      = local_file.alpha_key.filename
    destination = "/home/ec2-user/.ssh/alpha1.pem"

    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = tls_private_key.ec2-alpha_key.private_key_pem
      host        = aws_eip.bastion_eip.public_ip
    }
  }
  provisioner "remote-exec" {
    inline = [
      "chmod 400 /home/ec2-user/.ssh/alpha1.pem",
      "echo '${tls_private_key.ec2-alpha_key.public_key_openssh}' >> /home/ec2-user/.ssh/authorized_keys"
    ]
    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = tls_private_key.ec2-alpha_key.private_key_pem
      host        = aws_eip.bastion_eip.public_ip
    }
  }
}


###private-host###
resource "aws_instance" "myprivate_instance" {
  ami                    = var.instance-ami
  instance_type          = var.instance-type
  key_name               = aws_key_pair.gen_key.key_name
  availability_zone      = "ap-southeast-1a"
  subnet_id              = aws_subnet.private-subnet-1a.id
  vpc_security_group_ids = [aws_security_group.private_sg.id]


  tags = {
    Name = "myprivate_instance"
  }
}

