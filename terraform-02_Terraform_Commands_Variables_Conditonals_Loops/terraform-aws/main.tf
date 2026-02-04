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
}

locals {
  mytag         = "my-local-name"
  creation_date = timestamp()
  username      = var.user_name
}

resource "aws_instance" "tf-ec2" {
  ami           = var.ec2_ami
  instance_type = var.ec2_type
  key_name      = var.key_name # write your pem file without .pem extension
  tags = {
    "Name" = "${local.mytag}-test-${local.username}"
  }
}

resource "aws_s3_bucket" "tf-s3" {
  bucket = var.s3_bucket_name
  tags = {
    "Name" = "${local.mytag}-test-${local.username}"
    date   = local.creation_date
  }
}


