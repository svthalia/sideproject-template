# Example: Examplecie

This example shows how you might use the `sideproject` module to create infrastructure.

We assume the 'Examplecie' needs a website. They would like an EC2 instance to run their
Django application, with a volume for their database (to be beacked up daily), and an S3
bucket to store their media files.

To achieve this, we create a `main.tf` that is the root of their Terraform configuration.
This file imports the `sideproject` module, and configures it with the required variables.

Additionally, as an example, we allow the EC2 instance to log to AWS CloudWatch, which
is not provided by the `sideproject` module, but done separately.


You can now take a look at [`main.tf`](main.tf).

## Deploying

To deploy this configuration, someone with the required access to AWS (i.e. the Technicie)
installs Terraform and the AWS CLIsets up their credentials, and runs the following commands:

```bash
# From the directory containing main.tf:
terraform init  # This installs the required Terraform providers and modules.
terraform plan  # This shows the changes that will be made.

# If the plan looks good:
terraform apply  # This applies the changes.

# At this point, the infrastructure is ready for the Examplecie to use.

# Some time when the infrastructure is no longer needed:
terraform destroy  # This destroys the infrastructure.
```