variable "project_id" {
  description = "The project ID to host the cluster in"
}

variable "region" {
  description = "The region to host the cluster in"
  default     = "us-central1"
}

variable "zone" {
  description = "The zone to host the cluster in (required if is a zonal cluster)"
  default     = "us-central1-a"
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
      initial_node_count = 1
      min_node_count     = 1
      max_node_count     = 1
      spot               = true
      auto_repair        = true
      auto_upgrade       = true
      disk_size_gb       = 10
      disk_type          = "pd-standard"
      tags = [
        "ingress"
      ]
      taints = [
        {
          key    = "ingress"
          value  = true
          effect = "NO_EXECUTE"
        }
      ]
    }
    shared = {
      initial_node_count = 1
      min_node_count     = 1
      max_node_count     = 5
      spot               = true
      auto_repair        = true
      auto_upgrade       = true
      disk_size_gb       = 20
      disk_type          = "pd-standard"
      taints             = []
      tags = [
        "shared"
      ]
    }
  }
}

variable "default_machine_type" {
  description = "The default machine type for the cluster nodes"
  default     = "e2-small"
}

variable "cluster_subnetwork_cidr_range" {
  description = "The CIDR range for the cluster subnetwork"
  default     = "10.0.0.0/24"
}

variable "master_ipv4_cidr_block" {
  description = "The CIDR range for the master nodes"
  default     = "10.1.0.0/28"
}

variable "cluster_ipv4_cidr_block" {
  description = "The CIDR range for the cluster pods"
  default     = "10.2.0.0/18"
}

variable "services_ipv4_cidr_block" {
  description = "The CIDR range for the cluster services"
  default     = "10.3.0.0/18"
}
