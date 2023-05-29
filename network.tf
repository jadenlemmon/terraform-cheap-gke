resource "google_compute_network" "default" {
  name                    = var.network_name
  auto_create_subnetworks = "false"
  project                 = var.project_id
  routing_mode            = "REGIONAL"
}

resource "google_compute_address" "static-ingress" {
  name     = "static-ingress"
  project  = var.project_id
  region   = var.region
  provider = google-beta

  labels = {
    kubeip = "static-ingress"
  }
}

resource "google_compute_firewall" "default" {
  name    = "public-ingress"
  network = google_compute_network.default.self_link
  project = var.project_id

  allow {
    protocol = "tcp"
    ports    = ["80", "443"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = var.node_pools.ingress.tags
}
