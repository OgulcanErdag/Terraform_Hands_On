Terraform module that provisions an AWS EC2 instance using the latest Amazon Linux 2023 AMI with Docker pre-installed.

This module is for demonstration purposes only and not intended for production use.

It serves as an example to illustrate how to create and publish a module on the Terraform Registry.

Usage:

```hcl
provider "aws" {
  region = "us-east-1"
}

module "docker_instance" {
    source = "OgulcanErdag/docker-instance/aws"
    key_name = "mykey"
}
```