module "tf-vpc" {
  source              = "../modules"
  environment         = "prod"
  private-subnet-cidr = "10.0.5.0/24"
}

output "priv-subnet-cidr" {
  value = module.tf-vpc.private-subnet-cidr
}
