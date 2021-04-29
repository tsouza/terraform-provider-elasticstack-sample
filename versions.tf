terraform {
  required_version = "> 0.15"
  required_providers {
    ec = {
      source = "elastic/ec"
      version = "0.1.1"
    }
  }
}