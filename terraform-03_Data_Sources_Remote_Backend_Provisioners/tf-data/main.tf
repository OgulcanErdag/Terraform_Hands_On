terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.0.0"
    }
  }
  backend "s3" {
    bucket       = "tf-remote-s3-bucket-ogireis"
    key          = "env/dev/tf-remote-backend.tfstate"
    region       = "us-east-1"
    encrypt      = true
    use_lockfile = true
  }
}

provider "aws" {
  region = "us-east-1"
}

locals {
  mytag = "ogulcan"
}

data "aws_ami" "tf_ami" {
  most_recent = true
  owners      = ["self"]

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "name"
    values = ["ogi*"]
  }
}

variable "ec2_type" {
  default = "t3.micro"
}

resource "aws_instance" "tf-ec2" {
  ami           = data.aws_ami.tf_ami.id
  instance_type = var.ec2_type
  key_name      = "ogi-us-key"
  tags = {
    Name = "${local.mytag}-this is from my-ami"
  }
}

resource "aws_s3_bucket" "tf-test-1" {
  bucket = "test-1-versioning-ogireis"
}

resource "aws_s3_bucket" "tf-test-2" {
  bucket = "test-2-locking-ogireis"
}

resource "aws_s3_bucket" "tf-test-3" {
  bucket = "test-2-locking-ogireisbey"
}

resource "aws_s3_bucket" "tf-test-4" {
  bucket = "test-2-locking-ogireisbey-1"
}
