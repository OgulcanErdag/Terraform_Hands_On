terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>6.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

# import {
#   to = aws_instance.tf-instances
#   id = "i-08fd95537dd666086"
# }

resource "aws_instance" "tf-instances" {
  ami           = "ami-0532be01f26a3de55"
  instance_type = "t3.micro"
  key_name      = "ogi-us-key"
  tags = {
    Name = "test-ec2"
  }
}



resource "aws_security_group" "ogi-sec-grp" {
  vpc_id      = "vpc-0a596a2df5fa54814"
  description = "SSH-HTTP"
}



# import {
#   to = aws_security_group.ogi-sec-grp
#   id = "sg-09d80333bc270eecd"
# }

