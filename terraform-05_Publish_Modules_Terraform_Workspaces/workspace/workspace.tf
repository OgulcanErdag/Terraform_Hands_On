provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "tfmyec2" {
  ami           = lookup(var.myami, terraform.workspace)
  instance_type = terraform.workspace == "dev" ? "t3.micro" : "t3.small"
  count         = terraform.workspace == "prod" ? 3 : 1
  key_name      = "ogi-us-key"
  tags = {
    Name = "${terraform.workspace}-server"
  }
}

variable "myami" {
  type = map(string)
  default = {
    default = "ami-01b799c439fd5516a" # Amazon Linux 2023
    dev     = "ami-0583d8c7a9c35822c" # Red Hat Enterprise Linux 9
    prod    = "ami-04b70fa74e45c3917" # Ubuntu Server 22.04 LTS
  }
}

output "ami" {
  value = aws_instance.tfmyec2.*.ami
}

output "type" {
  value = aws_instance.tfmyec2.*.instance_type
}

output "tags" {
  value = aws_instance.tfmyec2.*.tags
}
