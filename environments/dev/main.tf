module "vpc" {
    source = "../../modules/network/vpc"
    vpc_cidr = var.vpc_cidr
}

module "public_subnet" {
    source = "../../modules/network/subnet"
    vpc_id = module.vpc.vpc_id
    subnet_cidr = var.public_subnet_cidr 
    az = var.az
}

module "private_subnet" {
    source = "../../modules/network/subnet"
    vpc_id = module.vpc.vpc_id
    subnet_cidr = var.private_subnet_cidr
    az = var.az 
}

module "network" {
  source = "../../modules/network/network-module"

  vpc_id            = module.vpc.vpc_id
  public_subnet_id  = module.public_subnet.subnet_id
  private_subnet_id = module.private_subnet.subnet_id
}

module "security" {
  source  = "../../modules/security/sg"
  vpc_id  = module.vpc.vpc_id
}

module "ec2" {
  source = "../../modules/compute"
  name = "joo-ec2-213214e"
  instance_type = "t2.micro"
  key_name      = "jookey"
  subnet_id     = module.public_subnet.subnet_id
  sg_id         = module.security.sg_id
}

output "vpc_id" {
  value = module.vpc.vpc_id 
}