resource "aws_ami_from_instance" "nautilus_ec2_ami" {
  name               = "nautilus-ec2-ami"
  source_instance_id = aws_instance.ec2.id

  # Optional but recommended
  snapshot_without_reboot = true

  tags = {
    Name = "nautilus-ec2-ami"
  }
}
