variable "project_name" {
  description = "Project name"
  type        = string
}

variable "stage" {
  description = "The deployment stage"
  type        = string
}

variable "zone_name" {
  description = "The route53 hosted zone to use"
  type        = string
  default     = "thalia.nu"
}

variable "domain" {
  description = "Domain name used to host the application in this stage"
  type        = string
}

variable "ssh_public_key" {
  description = "SSH public key to use to SSH into the EC2 instance"
  type        = string
}

variable "ec2_instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3a.small"
}

variable "ec2_ami" {
  description = "EC2 AMI"
  type        = string
  default     = "ami-089f338f3a2e69431" # Debian 11 (amd64, eu-west-1)
}

variable "ec2_root_volume_size" {
  description = "Size of the root volume in GiB"
  type        = number
  default     = 20
}

variable "volumes" {
  description = "Optional map of additional mounted EBS volumes. Keys are names (suffixes), values have `size` and `device_name` attributes. See https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/device_naming.html for valid device names."
  type        = map(object({ size = number, device_name = string }))
  default     = {}
}

variable "s3_buckets" {
  description = "Optional map of S3 buckets. Keys are names (suffixes), values have `versioning` attributes."
  type        = map(object({ versioning = string }))
  default     = {}
}
