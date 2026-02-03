terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.30.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
  # access_key = "my-access-key"
  # secret_key = "my-secret-key"
  ## profile = "my-profile"
}
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance

resource "aws_instance" "tf-ec2" {
  ami           = "ami-0532be01f26a3de55"
  instance_type = "t3.micro"
  tags = {
    "Name" = "created-by-tf"
    "env"  = "test" # tags can be more than one
  }
}

resource "aws_s3_bucket" "tf-s3" {
  bucket = "ogulcan-tf-bucket-13"
}
