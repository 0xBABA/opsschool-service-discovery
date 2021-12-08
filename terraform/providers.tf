terraform {
  required_version = "~> 1.0.11"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.68.0"
    }
  }
}

##################################################################################
# PROVIDERS
##################################################################################
provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      owner   = var.owner_tag
      purpose = var.purpose_tag
      context = var.context_tag
    }
  }
}
