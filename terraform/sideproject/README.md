# Terraform side project module

This module defines an easy-to-configure side project infrastructure with:
- A single EC2 instance (+ network with ports 22, 80 and 443 exposed, and DNS).
- Optional additional mounted EBS volumes, that are backed up daily.
- Optional S3 bucket(s).

The module outputs the EC2 instance's role ID, which can be used to attach additional
policies to it, for example to give the instance permission to resources that are not 
provided by this module (such as a CloudFront Distribution, or AWS MediaConvert).

## Example

There is an example in [`examples/examplecie`](examples/examplecie/README.md).

## Usage

Deploying infrastructure requires having access to AWS. So this should usually be done by the Technicie.

To use Terraform, you need to have the AWS CLI installed (https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli), and have AWS IAM user credentials configured, with a `~/.aws/credentials` file that looks like this:

```
[thalia]
aws_access_key_id=***
aws_secret_access_key=*****
```

You can then run `terraform init` and `terraform apply`.

