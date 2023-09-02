output "aws_interface_id" {
  description = "An AWS network interface ID for the server to use."
  value       = aws_network_interface.this.id
}

output "public_ipv4" {
  value = aws_eip.this.public_ip
}

output "public_ipv6" {
  value = one(aws_network_interface.this.ipv6_addresses)
}
