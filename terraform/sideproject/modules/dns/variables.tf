variable "zone_name" {
  description = "The route53 hosted zone to use"
  type        = string
}

variable "webdomain" {
  description = "The web domain you want to use"
  type        = string
}

variable "public_ipv4" {
  description = "The IPv4 address of the server"
  type        = string
}

variable "public_ipv6" {
  description = "The IPv6 address of the server"
  type        = string
}
