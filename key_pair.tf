# Generate a private and public key pair
resource "tls_private_key" "xfusion_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# Add to public key
resource "aws_key_pair" "xfusion_kp" {
  key_name   = "xfusion-kp"
  public_key = tls_private_key.xfusion_key.public_key_openssh
}

# Save private key locally (optional but common)
resource "local_file" "xfusion_private_key" {
  content         = tls_private_key.xfusion_key.private_key_pem
  filename        = "/home/bob/xfusion-kp.pem"
  file_permission = "0400"
}

output "key_pair_name" {
  value = aws_key_pair.xfusion_kp.key_name
}
