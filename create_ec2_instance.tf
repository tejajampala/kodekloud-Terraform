
############################
# Generate RSA key (Terraform)
############################
resource "tls_private_key" "nautilus_kp" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

############################
# Create AWS key pair
############################
resource "aws_key_pair" "nautilus_kp" {
  key_name   = "nautilus-kp"
  public_key = tls_private_key.nautilus_kp.public_key_openssh
}

############################
# Fetch default VPC
############################
data "aws_vpc" "default" {
  default = true
}

############################
# Fetch default security group
############################
data "aws_security_group" "default" {
  name   = "default"
  vpc_id = data.aws_vpc.default.id
}

############################
# Create EC2 instance
############################
resource "aws_instance" "nautilus_ec2" {
  ami                    = "ami-0c101f26f147fa7fd"
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.nautilus_kp.key_name
  vpc_security_group_ids = [data.aws_security_group.default.id]

  tags = {
    Name = "nautilus-ec2"
  }
}
