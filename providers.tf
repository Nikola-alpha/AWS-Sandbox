terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.58.0"
    }
  }

  backend "s3" {
    bucket  = "nikolabuckup"
    key     = "tf-lab/terraform.tfstate"
    region  = "ap-southeast-1"
    profile = "default"
  }
}

provider "aws" {
  region  = "ap-southeast-1"
  profile = "default"
}


