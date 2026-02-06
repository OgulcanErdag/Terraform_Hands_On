module "tf-vpc" {
  source      = "../modules"
  environment = "dev"
  # public-subnet-cidr = "10.0.3.0/24"
}

output "vpc_cidr-block" {
  value = module.tf-vpc.vpc_cidr
}
