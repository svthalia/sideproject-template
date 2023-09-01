variable "tags" {
  description = "AWS tags for resources"
  type        = map(string)
}

variable "name_suffix" {
  description = "Suffix for the bucket name"
  type        = string
}

variable "versioning" {
  description = "Versioning status"
  type        = string
  default     = "Disabled"
}

variable "ec2_role_id" {
  description = "ID of the IAM role give permission to access the bucket"
  type        = string
}
