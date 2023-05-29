provider "google" {
  project = var.project_id
  region  = "us-central1"
}

module "cheap-gke" {
  source = "../"

  project_id = var.project_id
  region     = "us-central1"
}
