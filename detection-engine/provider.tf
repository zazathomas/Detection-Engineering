terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.63.1"
    }
  }
}

# Use Oreilly Sandbox AWS accounts
provider "aws" {
  region = "us-east-1"
  access_key = "AKI..."
  secret_key = "Rmt..."
}

