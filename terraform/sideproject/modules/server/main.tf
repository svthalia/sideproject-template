# Key pair for SSH access into the instance.
resource "aws_key_pair" "this" {
  key_name   = "${var.tags.Name}-ssh-key"
  public_key = var.ssh_public_key

  tags = var.tags
}

# The EC2 instance.
resource "aws_instance" "this" {
  ami           = var.ec2_ami
  instance_type = var.ec2_instance_type

  iam_instance_profile = aws_iam_instance_profile.this.id

  root_block_device {
    volume_size = var.ec2_root_volume_size
  }

  network_interface {
    network_interface_id = var.aws_interface_id
    device_index         = 0
  }

  key_name = aws_key_pair.this.key_name

  tags = var.tags
}

# IAM role that we can use to give the EC2 instance permissions to use other resources.
# By itself, this role does nothing, but we can attach policies to it as needed.
resource "aws_iam_role" "this" {
  name               = "${var.tags.Name}-iam-role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_instance_profile" "this" {
  name = "${var.tags.Name}-ec2-profile"
  role = aws_iam_role.this.id
}

# Optional EBS volumes.
resource "aws_ebs_volume" "volumes" {
  for_each = var.volumes

  availability_zone = "eu-west-1a"
  size              = each.value.size

  tags = merge(var.tags, {
    Name     = "${var.tags.Name}-${each.key}",
    Snapshot = true,
  })
}

resource "aws_volume_attachment" "this" {
  for_each = var.volumes

  device_name = each.value.device_name
  volume_id   = aws_ebs_volume.volumes[each.key].id
  instance_id = aws_instance.this.id
}


