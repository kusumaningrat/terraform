provider "aws" {
  region = "ap-southeast-1"
  profile = "default"
}

module "vpc" {
  source = "./modules/vpc"
  vpc_names = var.vpc_names
  vpc_cidr_blocks = var.vpc_cidr_blocks
  subnet_names = var.subnet_names
  subnet_cidr_blocks = var.subnet_cidr_blocks
}

module "ec2" {
  source        = "./modules/ec2"
  ami_id        = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name
  vpc_ids       = module.vpc.vpc_ids
  subnet_a_ids  = module.vpc.subnet_a_ids  # Pass subnet A IDs
  subnet_b_ids  = module.vpc.subnet_b_ids  # Pass subnet B IDs
  subnet_cidr_blocks = var.subnet_cidr_blocks
}