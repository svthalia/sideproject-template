output "ec2_role_id" {
  value = module.server.ec2_role_id
}

output "bucket_arns" {
  value = { for name, bucket in module.buckets : name => bucket.arn }
}
