# Side project template

This repository is a template for any side project you might want to start.
It is useful for example if you're making a website for an event. 
Some examples from the past where such a template would be useful are:

- A website for Thalia's Symposium
- A website for the introduction week.

This template contains the following stuff:

- A reusable [Terraform](https://developer.hashicorp.com/terraform) module to manage cloud infrastructure on AWS.
  This can be used in your own repository without copying the source, as shown in the [example](terraform/sideproject/examples/examplecie/main.tf), by using:
  ```terraform
  module "sideproject" {
      source = "github.com/svthalia/sideproject-template//terraform/sideproject?ref=main"
      # ...
  }
  ```

