variable "bucket_name" {
  type        = string
  description = "Remote state bucket name"
}

variable "vpc_cidr" {
  type        = string
  description = "Public Subnet CIDR values"
}

variable "vpc_name" {
  type        = string
  description = "DevOps Project 1 VPC 1"
}

variable "cidr_public_subnet" {
  type        = list(string)
  description = "Public Subnet CIDR values"
}

variable "cidr_private_subnet" {
  type        = list(string)
  description = "Private Subnet CIDR values"
}

variable "eu_availability_zone" {
  type        = list(string)
  description = "Availability Zones"
}

variable "public_key" {
  type        = string
  description = "DevOps Project 1 Public key for EC2 instance"
}

variable "ec2_ami_id" {
  type        = string
  description = "DevOps Project 1 AMI Id for EC2 instance"
}

variable "ec2_ami_instance" {
  type        = string
  description = "DevOps Project 1 AMI Id for EC2 instance type"
}

variable "region" {
  type        = string
  description = "AWS Region" 
}

variable "project_name" {
  type        = string
  description = "Project name"
}

variable "domain_name" {
  type        = string
  description = "Domain name"
}

variable "endpoint_name" {
  type        = string
  description = "Endpoint name"
}

variable "home_path" {
  type        = string
  description = "Home path"
}

variable "rsa_file" {
  type        = string
  description = "rsa path"
}

variable "rds_db_name" {
  type        = string
  description = "RDS DB name"
}

variable "rds_db_username" {
  type        = string
  description = "RDS DB username"
}

variable "rds_db_password" {
  type        = string
  description = "RDS DB password"
}

variable "rds_db_instance_class" {
  type        = string
  description = "RDS DB instance class"
}