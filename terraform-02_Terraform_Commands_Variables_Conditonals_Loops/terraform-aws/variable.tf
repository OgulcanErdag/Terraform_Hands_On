variable "ec2_name" {
  default = "ogulcan-tf-ec2"
}

variable "ec2_type" {
  default = "t3.micro"
}

variable "ec2_ami" {
  default = "ami-0532be01f26a3de55"
}

variable "key_name" {
  default = "ogi-us-key"
}

variable "user_name" {
  default = "ogulcan"
}

variable "s3_bucket_name" {
  # default = "tf-test-bucket-ogulcan"
}
