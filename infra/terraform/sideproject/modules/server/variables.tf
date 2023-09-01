variable "tags" {
  description = "AWS tags for resources"
  type        = map(string)
}

variable "aws_interface_id" {
  description = "ID of the AWS network interface to attach to the EC2 instance"
  type        = string
}

variable "ssh_public_key" {
  description = "SSH public key to use to SSH into the EC2 instance"
  type        = string
}

variable "ec2_instance_type" {
  description = "EC2 instance type"
  type        = string
}

variable "ec2_ami" {
  description = "EC2 AMI"
  type        = string
}

variable "ec2_root_volume_size" {
  description = "Size of the root volume in GiB"
  type        = number
}

variable "volumes" {
  description = "Optional map of additional mounted EBS volumes. Keys are names (suffixes), values have `size` and `device_name` attributes. See https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/device_naming.html for valid device names."
  type        = map(object({ size = number, device_name = string }))
  default     = {}
}

