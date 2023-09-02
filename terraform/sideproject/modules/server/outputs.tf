output "ec2_role_id" {
  description = "An IAM role to which policies can be attached to give the EC2 instance permissions to use other resources"
  value = aws_iam_role.this.id
}
