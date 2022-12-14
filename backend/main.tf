provider "aws" {
  region = var.aws-region
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>4.0"
    }
  }
#   backend "s3" {
#     bucket  = "junglemeet-statefile"
#     encrypt = true
#     key     = "backend/terraform.tfstate"
#     region  = "us-east-1"
# #     dynamodb_table = "terraform-statelock-backend"
#   }
}

# resource "aws_dynamodb_table" "terraform-statelock-backend" {
#   name           = "terraform-statelock-backend"
#   hash_key       = "LockID"
#   read_capacity  = 20
#   write_capacity = 20
#   attribute {
#     name = "LockID"
#     type = "S"
#   }
#   tags = {
#     Name = "DynamoDB Terraform State Lock Table"
#   }
# }

module "route53" {
  source      = "./route53"
  domain_name = var.domain_name
  dns_name    = module.alb.alb_dns_name
}

module "vpc" {
  source             = "./vpc"
  name               = var.name
  cidr               = var.cidr
  private_subnets    = var.private_subnets
  public_subnets     = var.public_subnets
  availability_zones = var.availability_zones
  environment        = var.environment
}

module "security_groups" {
  source         = "./security-groups"
  name           = var.name
  vpc_id         = module.vpc.id
  environment    = var.environment
  container_port = var.container_port
}

module "alb" {
  source      = "./alb"
  name        = var.name
  vpc_id      = module.vpc.id
  subnets     = module.vpc.public_subnets
  environment = var.environment
  acm_arn = module.route53.acm_arn
  alb_security_groups = [module.security_groups.alb]
  alb_tls_cert_arn    = var.tsl_certificate_arn
  health_check_path   = var.health_check_path
}

module "ecs" {
  source                      = "./ecs"
  name                        = var.name
  environment                 = var.environment
  region                      = var.aws-region
  subnets                     = module.vpc.private_subnets
  aws_alb_target_group_arn    = module.alb.aws_alb_target_group_arn
  ecs_service_security_groups = [module.security_groups.ecs_tasks]
  container_port              = var.container_port
  container_image             = var.container_image
  container_cpu               = var.container_cpu
  container_memory            = var.container_memory
  service_desired_count       = var.service_desired_count
  container_environment = [
    { name = "LOG_LEVEL",
    value = "DEBUG" },
    { name = "PORT",
    value = var.container_port }
  ]
}

