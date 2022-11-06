terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
  backend "s3" {
    bucket         = "junglemeet-statefile"
    key            = "frontend/terraform.tfstate"
    region         = "us-east-1"
#     dynamodb_table = "terraform-statelock-frontend"
  }
}



provider "aws" {
  region = "ap-southeast-2"
}

provider "aws" {
  alias  = "acm_provider"
  region = "us-east-1"
}
