terraform {
  required_version = "> 0.15"
  required_providers {
    elasticstack = {
      source  = "tsouza/elasticstack"
      version = "0.0.3-pre"
    }
    ec = {
      source  = "elastic/ec"
      version = "0.1.1"
    }
    aws = {
      source  = "hashicorp/aws"
      version = ">= 3"
    }
  }
}