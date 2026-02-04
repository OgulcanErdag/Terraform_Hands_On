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

# variable "num_of_buckets" {
#   default = 2
# }

variable "s3_bucket" {
  default = "new-s3-bucket-ogulcan-devops13-tr"
}

variable "users" {
  default = ["aakadir", "aaogulcan", "aababek"]
}

resource "aws_s3_bucket" "tf-s3" {
  # bucket = "${var.s3_bucket}-${count.index + 1}"
  # count  = var.num_of_buckets
  # count = var.num_of_buckets != 0 ? var.num_of_buckets : 3
  for_each = toset(var.users)
  bucket   = "example-tf-s3-bucket${each.value}"
}

resource "aws_iam_user" "new_users" {
  for_each = toset(var.users)
  name     = each.value
}
