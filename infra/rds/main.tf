# variable "db_instance_identifier" {}
# variable "db_engine" {}
# variable "db_instance_class" {}
# variable "db_username" {}
# variable "db_password" {}
# variable "db_name" {}
# variable "vpc_security_group_ids" {}
# variable "subnet_ids" {}

# resource "aws_db_instance" "postgres_instance" {
#     identifier             = var.db_instance_identifier
#     engine                 = var.db_engine
#     engine_version         = "15.8"
#     instance_class         = var.db_instance_class
#     allocated_storage      = 20
#     storage_type           = "gp2"
#     username               = var.db_username
#     password               = var.db_password
#     publicly_accessible   = false
#     multi_az               = false
#     vpc_security_group_ids = var.vpc_security_group_ids
# }