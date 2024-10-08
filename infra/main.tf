module "networking" {
  source               = "./networking"
  vpc_cidr             = var.vpc_cidr
  vpc_name             = var.vpc_name
  cidr_public_subnet   = var.cidr_public_subnet
  eu_availability_zone = var.eu_availability_zone
  cidr_private_subnet  = var.cidr_private_subnet
}

module "security_group" {
  source              = "./security-groups"
  ec2_sg_name         = "SG for EC2 to enable SSH(22), HTTPS(443) and HTTP(80)"
  vpc_id              = module.networking.node098_vpc_id
}

module "node" {
  source                    = "./node"
  ami_id                    = var.ec2_ami_id
  instance_type             = var.ec2_ami_instance
  tag_name                  = "node098:Ubuntu Linux EC2"
  public_key                = var.public_key
  subnet_id                 = tolist(module.networking.node098_public_subnets)[0]
  sg_for_node               = [
                              module.security_group.sg_ec2_sg_ssh_http_id,
                              module.security_group.sg_ec2_node_port_3000,
                            ]
  enable_public_ip_address  = true
  user_data = templatefile("./template/node-installer.sh", {})
}

module "lb_target_group" {
  source                   = "./load-balancer-target-group"
  lb_target_group_name     = "node098-lb-target-group"
  lb_target_group_port     = 3000
  lb_target_group_protocol = "HTTP"
  vpc_id                   = module.networking.node098_vpc_id
  ec2_instance_id          = module.node.node_ec2_instance_id
}

module "alb" {
  source                    = "./load-balancer"
  lb_name                   = "node098-alb"
  is_external               = false
  lb_type                   = "application"
  sg_enable_ssh_https       = module.security_group.sg_ec2_sg_ssh_http_id
  subnet_ids                = tolist(module.networking.node098_public_subnets)
  tag_name                  = "node098-alb"
  lb_target_group_arn       = module.lb_target_group.node098_lb_target_group_arn
  ec2_instance_id           = module.node.node_ec2_instance_id
  lb_listner_port           = 80
  lb_listner_protocol       = "HTTP"
  lb_listner_default_action = "forward"
  lb_https_listner_port     = 443
  lb_https_listner_protocol = "HTTPS"
  node098_acm_arn        = module.aws_ceritification_manager.node098_acm_arn
  lb_target_group_attachment_port = 3000
}

module "hosted_zone" {
  source          = "./hosted-zone"
  domain_name     = "node098.shadowghosts.xyz"
  dbadmin_domain_name = "dbadmin-node098.shadowghosts.xyz"
  sonarqube_domain_name = "sonarqube-node098.shadowghosts.xyz"
  ec2_instance_public_ip = module.node.node098_ec2_instance_public_ip
  aws_lb_dns_name = module.alb.aws_lb_dns_name
  aws_lb_zone_id  = module.alb.aws_lb_zone_id
}

module "aws_ceritification_manager" {
  source         = "./certificate-manager"
  domain_name    = "node098.shadowghosts.xyz"
  hosted_zone_id = module.hosted_zone.hosted_zone_id
}

# module "rds" {
#   source                  = "./rds"
#   db_instance_identifier  = "node098-rds"
#   db_engine               = "postgres"
#   db_instance_class       = var.rds_db_instance_class
#   db_username             = var.rds_db_username
#   db_password             = var.rds_db_password
#   db_name                 = var.rds_db_name
#   vpc_security_group_ids  = [module.security_group.sg_db_port]
# }