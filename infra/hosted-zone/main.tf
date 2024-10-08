variable "domain_name" {}
variable "dbadmin_domain_name" {}
variable "sonarqube_domain_name" {}
variable "aws_lb_dns_name" {}
variable "aws_lb_zone_id" {}
variable "ec2_instance_public_ip" {}

data "aws_route53_zone" "node098_domain" {
  name         = "shadowghosts.xyz"
  private_zone = false
}

resource "aws_route53_record" "lb_record" {
  zone_id = data.aws_route53_zone.node098_domain.zone_id
  name    = var.domain_name
  type    = "A"

  alias {
    name                   = var.aws_lb_dns_name
    zone_id                = var.aws_lb_zone_id
    evaluate_target_health = true
  }
}

output "hosted_zone_id" {
  value = data.aws_route53_zone.node098_domain.zone_id
}

# resource "aws_route53_record" "dbadmin_record" {
#   zone_id = data.aws_route53_zone.node098_domain.zone_id
#   name    = var.dbadmin_domain_name
#   type    = "A"

#   alias {
#     name                   = var.ec2_instance_public_ip
#     zone_id                = data.aws_route53_zone.node098_domain.zone_id
#     evaluate_target_health = true
#   }
# }


# resource "aws_route53_record" "sonarqube_record" {
#   zone_id = data.aws_route53_zone.node098_domain.zone_id
#   name    = var.sonarqube_domain_name
#   type    = "A"

#   alias {
#     name                   = var.ec2_instance_public_ip
#     zone_id                = data.aws_route53_zone.node098_domain.zone_id
#     evaluate_target_health = true
#   }
# }