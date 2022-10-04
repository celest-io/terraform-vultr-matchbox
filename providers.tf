terraform {
  required_providers {
    matchbox = {
      source  = "poseidon/matchbox"
      version = ">=0.5"
    }
    vultr = {
      source  = "vultr/vultr"
      version = ">=2.11"
    }
  }
  required_version = ">= 1.0"
}
