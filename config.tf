terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.81.0"
    }
  }
}

provider "google" {
  user_project_override = true
  region                = "asia-northeast1"
}
