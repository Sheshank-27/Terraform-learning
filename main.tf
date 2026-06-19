module "vpc" {
  source = "./modules/vpc"

  vpc_cidr = "10.0.0.0/16"

}

module "ec2" {
  source = "./modules/ec2"

  vpc_id  = module.vpc.vpc_id
  subnet1 = module.vpc.public_subnet1
  subnet2 = module.vpc.public_subnet2
}

module "alb" {
  source = "./modules/alb"

  vpc_id    = module.vpc.vpc_id
  web_sg    = module.ec2.web_sg
  instance1 = module.ec2.instance1
  instance2 = module.ec2.instance2
  subnet1   = module.vpc.public_subnet1
  subnet2   = module.vpc.public_subnet2
}