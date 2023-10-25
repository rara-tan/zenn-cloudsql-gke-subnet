resource "google_compute_network" "main_network" {
  project                 = var.project_id
  name                    = "main-network"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "main_subnetwork" {
  project       = var.project_id
  name          = "main-subnetwork"
  ip_cidr_range = "10.2.0.0/16"
  region        = "asia-northeast1"
  network       = google_compute_network.main_network.id
  secondary_ip_range {
    range_name    = "secondary-range-1"
    ip_cidr_range = "10.10.0.0/16"
  }
  secondary_ip_range {
    range_name    = "secondary-range-2"
    ip_cidr_range = "10.20.0.0/16"
  }
}

resource "google_project_service" "service_networking" {
  project            = var.project_id
  service            = "servicenetworking.googleapis.com"
  disable_on_destroy = false
}

resource "google_compute_global_address" "private_ip_address" {
  project       = var.project_id
  name          = "private-ip"
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 16
  network       = google_compute_network.main_network.id
}

resource "google_service_networking_connection" "default" {
  network                 = google_compute_network.main_network.id
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.private_ip_address.name]
}
