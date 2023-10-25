module "my-app-workload-identity" {
  source     = "terraform-google-modules/kubernetes-engine/google//modules/workload-identity"
  name       = "test-sa"
  namespace  = "default"
  project_id = var.project_id
  roles      = ["roles/cloudsql.client"]
}
