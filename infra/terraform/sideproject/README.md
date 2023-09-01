# Terraform side project module

This module defines an easy-to-configure side project infrastructure with:
- A single EC2 instance (+ network with ports 22, 80 and 443 exposed, and DNS).
- Optional additional mounted EBS volumes, that are backed up daily.
- Optional S3 bucket(s).

The module outputs the EC2 instance's role ID, which can be used to attach additional
policies to it, for example to give the instance permission to resources that are not 
provided by this module (such as a CloudFront Distribution, or to AWS MediaConvert).

