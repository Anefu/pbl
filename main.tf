provider "aws" {
  region = "us-east-1"
}
module "network" {
  source = "./modules/network"
  vpc_tags = {
      Name = "Terraform VPC"
  }
  public_subnet_tags = {
      Name = "Public subnet"
  }
  private_subnet_tags = {
      Name = "Private subnet tags"
  }
  nat_eip_tags = {
      Name = "Nat EIP"
  }
  nat_tags = {
      Name = "NAT"
  }
  ig_tags = {
      Name = "IG"
  }
}

module "alb" {
  source = "./modules/alb"
  vpc_id = module.network.vpc_id
  alb_security_group = ["${module.network.alb-sg}"]
  alb_subnet_ids = [module.network.public-subnets[0], module.network.public-subnets[1]]
  nginx_alb_tags = {
      Name = "Nginx ALB"
  }
  wordpress_alb_tags = {
      Name = "Wordpress ALB"
  }
  tooling_alb_tags = {
      Name = "Tooling ALB"
  }
}

module "compute" {
  source = "./modules/compute"
  security_groups = [module.network.bastion_sg]
  subnet_id = module.network.public-subnets[0]
}
module "asg" {
  source = "./modules/autoscaling"
  bastion_sg = [module.network.bastion_sg]
  bastion_subnets = [module.network.public-subnets[0],module.network.public-subnets[1]]
  bastion_tg_arn  = [module.alb.bastion-tg-arn]
}

module "efs" {
  source = "./modules/efs"
  efs_tags = {
      Name = "EFS"
  }
  efs_subnet_id = module.network.efs_subnets
  efs_sg = [module.network.efs_sg]
}

module "rds" {
  source = "./modules/rds"
  rds_subnets = [module.network.private-subnets[2],module.network.private-subnets[3]]
  rds_tags = {
      Name = "MySQL RDS"
  }
  db_name = "tooling"
  db_username = "webaccess"
  db_password = "admin1234"

}

module "security" {
  source = "./modules/security"
}