terraform {
  required_version = ">= 1.2.0"

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
