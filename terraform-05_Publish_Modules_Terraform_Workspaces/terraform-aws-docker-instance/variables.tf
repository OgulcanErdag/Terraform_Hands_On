variable "instance-type" {
  type        = string
  default     = "t3.micro"
  description = "Change the type according to your needs"
}

variable "key-name" {
  type        = string
  description = "Use your own key"
}

variable "num-of-instance" {
  type        = number
  default     = 1
  description = "Enter the number of instances to be provisioned"
}

variable "tag" {
  type    = string
  default = "Docker-Instance"
}

variable "server-name" {
  type    = string
  default = "docker-instance"
}

variable "docker-instance-ports" {
  type        = list(number)
  description = "docker-instance-sec-gr-inbound-rules"
  default     = [22, 80, 8080]
}
