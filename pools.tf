resource "google_container_node_pool" "node-pools" {
  for_each = var.node_pools

  depends_on         = [google_container_cluster.default]
  name               = each.key
  project            = var.project_id
  location           = var.zone
  cluster            = var.gke_cluster_name
  initial_node_count = each.value.initial_node_count

  autoscaling {
    min_node_count = lookup(each.value, "min_node_count", 1)
    max_node_count = lookup(each.value, "max_node_count", 2)
  }

  management {
    auto_repair  = lookup(each.value, "auto_repair", true)
    auto_upgrade = lookup(each.value, "auto_upgrade", true)
  }

  node_config {
    machine_type    = lookup(each.value, "machine_type", "f1-micro")
    disk_size_gb    = lookup(each.value, "disk_size_gb", 10)
    disk_type       = lookup(each.value, "disk_type", "pd-standard")
    spot            = lookup(each.value, "spot", false)
    service_account = lookup(each.value, "service_account", "")
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform",
      "https://www.googleapis.com/auth/trace.append",
      "https://www.googleapis.com/auth/service.management.readonly",
      "https://www.googleapis.com/auth/monitoring",
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/servicecontrol",
    ]

    workload_metadata_config {
      mode = "GKE_METADATA"
    }

    tags = each.value.tags

    dynamic "taint" {
      for_each = {
        for obj in each.value.taints : "${obj.key}_${obj.value}_${obj.effect}" => obj
      }
      content {
        effect = taint.value.effect
        key    = taint.value.key
        value  = taint.value.value
      }
    }
  }
}
