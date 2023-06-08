output "google_container_cluster" {
  value = resource.google_container_cluster.default
}

output "google_compute_address" {
  value = resource.google_compute_address.static-ingress
}
