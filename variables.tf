variable "project_id" {
  description = "The project ID to host the cluster in"
}

variable "region" {
  description = "The region to host the cluster in"
  default     = "us-south1"
}

variable "zone" {
  description = "The zone to host the cluster in (required if is a zonal cluster)"
  default     = "us-south1-a"
}

variable "network_name" {
  description = "The name of the network"
  default     = "gke-cluster-network"
}

variable "gke_cluster_name" {
  description = "The name of the cluster"
  default     = "gke-cheap-cluster"
}

variable "num_nodes" {
  description = "The number of cluster nodes"
  default     = 1
}

variable "disk_size" {
  description = "The disk size of the cluster nodes"
  default     = 20
}

variable "node_pools" {
  default = {
    ingress = {
      machine_type       = "e2-small"
      initial_node_count = 1
      min_node_count     = 1
      max_node_count     = 1
      spot               = true
      auto_repair        = true
      auto_upgrade       = true
      disk_size_gb       = 10
      disk_type          = "pd-standard"
    }
    shared = {
      machine_type       = "e2-small"
      initial_node_count = 1
      min_node_count     = 1
      max_node_count     = 5
      spot               = true
      auto_repair        = true
      auto_upgrade       = true
      disk_size_gb       = 20
      disk_type          = "pd-standard"
    }
  }
}

variable "node_pools_tags" {
  default = {
    ingress = [
      "ingress"
    ]
    shared = [
      "shared"
    ]
  }
}

variable "node_pools_taints" {
  default = {
    ingress = [
      {
        key    = "ingress"
        value  = true
        effect = "NO_EXECUTE"
      }
    ]
    shared = []
  }
}

variable "org_id" {
  type = string
}

variable "billing_account_id" {
  type = string
}
