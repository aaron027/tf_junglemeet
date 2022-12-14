variable "domain_name" {
  description = "the name of your domain name"
}

variable "name" {
  description = "the name of your stack"
}

variable "environment" {
  description = "the name of your environment"
  default     = "dev"
}

variable "region" {
  description = "the AWS region in which resources are created, you must set the availability_zones variable as well if you define this value to something other than the default"
  default     = "us-east-1"
}

variable "container_image" {
  description = "container image"
}

variable "aws-region" {
  type        = string
  description = "AWS region to launch servers."
  default     = "us-east-1"
}

variable "availability_zones" {
  description = "a comma-separated list of availability zones, defaults to all AZ of the region, if set to something other than the defaults, both private_subnets and public_subnets have to be defined as well"
  default     = ["us-east-1a", "us-east-1b", "us-east-1c"]
}

variable "cidr" {
  description = "The CIDR block for the VPC."
  default     = "10.0.0.0/16"
}

variable "private_subnets" {
  description = "a list of CIDRs for private subnets in your VPC, must be set if the cidr variable is defined, needs to have as many elements as there are availability zones"
  default     = ["10.0.0.0/20", "10.0.32.0/20", "10.0.64.0/20"]
}

variable "public_subnets" {
  description = "a list of CIDRs for public subnets in your VPC, must be set if the cidr variable is defined, needs to have as many elements as there are availability zones"
  default     = ["10.0.16.0/20", "10.0.48.0/20", "10.0.80.0/20"]
}

variable "service_desired_count" {
  description = "Number of tasks running in parallel"
  default     = 2
}

variable "container_port" {
  description = "The port where the Docker is exposed"
  default     = 3000
}

variable "container_cpu" {
  description = "The number of cpu units used by the task"
  default     = 1024
}

variable "container_memory" {
  description = "The amount (in MiB) of memory used by the task"
  default     = 2048
}

variable "health_check_path" {
  description = "Http path for task health check"
  default     = "/health-check"
}

variable "tsl_certificate_arn" {
  description = "The ARN of the certificate that the ALB uses for https"
}
