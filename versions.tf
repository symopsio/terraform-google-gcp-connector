terraform {
  required_version = ">= 0.13.7"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 5.7.0"
    }

    sym = {
      source  = "symopsio/sym"
      version = ">= 2.0"
    }
  }
}
