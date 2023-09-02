# This block configures Terraform itself.
terraform {
  required_version = ">=1.5.6"

  required_providers {
    aws = ">= 5.15.0"
  }

  # This determines where Terraform will store the current state of the infrastructure.
  # We have an S3 bucket for this purpose.
  backend "s3" {
    bucket  = "thalia-terraform-state"
    key     = "examplecie/production.tfstate"
    region  = "eu-west-1"
    profile = "thalia"
  }
}

provider "aws" {
  region  = "eu-west-1"
  profile = "thalia"
}

# We use the ready-made sideproject module to make most of the infrastructure.
module "sideproject" {
  # This is a url to the module. Since we use a github url, the `sideproject` 
  # source code does not have to be copied to the Examplecie's repository. 
  # A specific version can be specified with `?ref=XXX` part.
  # source = "github.com/svthalia/sideproject-template//terraform/sideproject?ref=main"

  # But for here, we use a local path. Use the git url above in your own real projects.
  source = "../../"

  project_name = "examplecie"
  stage        = "production"
  zone_name    = "thalia.nu"
  domain       = "examplecie.thalia.nu"

  # This is a public key that is used to SSH into the EC2 instance. It can be one owned
  # by the Examplecie, or by Technicie. More keys can be added once the instance exists.
  ssh_public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICUem6KgtL8HzLdLoXnkfXFwCQGSoiz+gSNAQlrTl30W"

  # Examplecie is fine with the default EC2 settings of a t3a.small instance with a 20GB
  # root volume, running Debian 11. So we don't have to specify those here.

  # We want a 5GB volume for a postgres database. This is backed up by default.
  volumes = {
    "postgres" = {
      size        = 5
      device_name = "/dev/sdf"
    }
  }

  # We want an S3 bucket for media, but don't need versioning.
  s3_buckets = {
    "media" = {
      versioning = "Disabled"
    }
  }
}

# If additional resources are needed, they can be added here.
# For example, we can add a policy to the EC2 role, that allows logging to CloudWatch.
resource "aws_iam_role_policy" "example_added_policy" {
  name   = "thalia-production-examplecie-example-added-policy"
  role   = module.sideproject.ec2_role_id
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents",
        "logs:DescribeLogStreams"
    ],
      "Resource": [
        "arn:aws:logs:*:*:*"
    ]
  }
 ]
}
EOF
}
