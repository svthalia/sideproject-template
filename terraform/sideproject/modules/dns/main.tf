data "aws_route53_zone" "primary" {
  name = var.zone_name
}

resource "aws_route53_record" "a" {
  zone_id         = data.aws_route53_zone.primary.zone_id
  name            = var.webdomain
  type            = "A"
  ttl             = "300"
  records         = [var.public_ipv4]
  allow_overwrite = true
}

resource "aws_route53_record" "aaaa" {
  zone_id         = data.aws_route53_zone.primary.zone_id
  name            = var.webdomain
  type            = "AAAA"
  ttl             = "300"
  records         = [var.public_ipv6]
  allow_overwrite = true
}
