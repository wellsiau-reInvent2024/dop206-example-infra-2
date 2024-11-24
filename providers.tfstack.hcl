required_providers {
  aws = {
    source  = "hashicorp/aws"
    version = "~> 5.7.0"
  }

  random = {
    source  = "hashicorp/random"
    version = "~> 3.5.1"
  }

  local = {
    source = "hashicorp/local"
    version = "~> 2.4.0"
  }
}

provider "aws" "configurations" {
  # Loop the provider block for each accounts in the var.accounts
  for_each  = var.accounts

  config {
    region = var.region

    assume_role_with_web_identity {
      role_arn           = "arn:aws:iam::${each.value}:role/${var.role_name}"
      web_identity_token = var.identity_token
    }

    default_tags {
      tags = var.default_tags
    }
  }
}

provider "random" "this" {}
provider "local" "this" {}