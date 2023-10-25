data "google_client_config" "default" {}

provider "kubernetes" {
  host                   = "https://${module.gke.endpoint}"
  token                  = data.google_client_config.default.access_token
  cluster_ca_certificate = base64decode(module.gke.ca_certificate)
}

module "gke" {
  source     = "terraform-google-modules/kubernetes-engine/google"
  project_id = var.project_id

  name                        = "test-cluster"
  regional                    = true
  region                      = "asia-northeast1"
  network                     = google_compute_network.main_network.name
  subnetwork                  = google_compute_subnetwork.main_subnetwork.name
  ip_range_pods               = "secondary-range-1"
  ip_range_services           = "secondary-range-2"
  create_service_account      = true
  enable_cost_allocation      = true
  enable_binary_authorization = false
  gcs_fuse_csi_driver         = true
}
