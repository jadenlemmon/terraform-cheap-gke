# Cheap GKE Cluster Terraform Module

Creating a GKE cluster in GCP often leaves you with default settings that aren't cost-effective. It's fair to say, for the purpose of creating clusters for testing and development, there's no need for features like multi-region, high availability, load balancers, and so on.

This module gives you a simple, no-fuss way to set up a GKE cluster that's optimized for development purposes. It's a result of extensive research to find a cost-effective solution.

Among all GCP regions, `us-central1` offers the most economical rates.

Spot instances are another way to trim your budget, offering a substantial discount of around 75% or more when compared to standard instances. By default, we utilize two node pools. The first, named ingress, operates on a single e2-small instance, serving as a budget-friendly load balancer. To ensure uninterrupted operation, this instance does not run on spot instances. The second node pool, shared, is configured to handle all additional workloads using spot instances.

## Example Usage

```
module "cheap-gke" {
  source  = "jadenlemmon/cheap-gke/google"

  project_id = "PROJECT_ID"
  region     = "us-central1"
}
```

## Release Process

Push a new tag and then draft a new Github Release.

```sh
git tag v0.1.0 && git push --tags
```

<!-- BEGIN_TF_DOCS -->

## Requirements

No requirements.

## Providers

| Name                                                                     | Version |
| ------------------------------------------------------------------------ | ------- |
| <a name="provider_google"></a> [google](#provider_google)                | n/a     |
| <a name="provider_google-beta"></a> [google-beta](#provider_google-beta) | n/a     |

## Modules

No modules.

## Resources

| Name                                                                                                                                                            | Type     |
| --------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------- |
| [google-beta_google_compute_address.static-ingress](https://registry.terraform.io/providers/hashicorp/google-beta/latest/docs/resources/google_compute_address) | resource |
| [google-beta_google_container_cluster.default](https://registry.terraform.io/providers/hashicorp/google-beta/latest/docs/resources/google_container_cluster)    | resource |
| [google_compute_firewall.default](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_firewall)                              | resource |
| [google_compute_network.default](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_network)                                | resource |
| [google_compute_router.router](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_router)                                   | resource |
| [google_compute_router_nat.nat](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_router_nat)                              | resource |
| [google_compute_subnetwork.default](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_subnetwork)                          | resource |
| [google_container_node_pool.node-pools](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/container_node_pool)                     | resource |

## Inputs

| Name                                                                              | Description                                                      | Type     | Default                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             | Required |
| --------------------------------------------------------------------------------- | ---------------------------------------------------------------- | -------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | :------: |
| <a name="input_disk_size"></a> [disk_size](#input_disk_size)                      | The disk size of the cluster nodes                               | `number` | `20`                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |    no    |
| <a name="input_gke_cluster_name"></a> [gke_cluster_name](#input_gke_cluster_name) | The name of the cluster                                          | `string` | `"gke-cheap-cluster"`                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |    no    |
| <a name="input_network_name"></a> [network_name](#input_network_name)             | The name of the network                                          | `string` | `"gke-cluster-network"`                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             |    no    |
| <a name="input_node_pools"></a> [node_pools](#input_node_pools)                   | n/a                                                              | `map`    | <pre>{<br> "ingress": {<br> "auto_repair": true,<br> "auto_upgrade": true,<br> "disk_size_gb": 10,<br> "disk_type": "pd-standard",<br> "initial_node_count": 1,<br> "machine_type": "e2-small",<br> "max_node_count": 1,<br> "min_node_count": 1,<br> "spot": true,<br> "tags": [<br> "ingress"<br> ],<br> "taints": [<br> {<br> "effect": "NO_EXECUTE",<br> "key": "ingress",<br> "value": true<br> }<br> ]<br> },<br> "shared": {<br> "auto_repair": true,<br> "auto_upgrade": true,<br> "disk_size_gb": 20,<br> "disk_type": "pd-standard",<br> "initial_node_count": 1,<br> "machine_type": "e2-small",<br> "max_node_count": 5,<br> "min_node_count": 1,<br> "spot": true,<br> "tags": [<br> "shared"<br> ],<br> "taints": []<br> }<br>}</pre> |    no    |
| <a name="input_num_nodes"></a> [num_nodes](#input_num_nodes)                      | The number of cluster nodes                                      | `number` | `1`                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |    no    |
| <a name="input_project_id"></a> [project_id](#input_project_id)                   | The project ID to host the cluster in                            | `any`    | n/a                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |   yes    |
| <a name="input_region"></a> [region](#input_region)                               | The region to host the cluster in                                | `string` | `"us-central1"`                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     |    no    |
| <a name="input_zone"></a> [zone](#input_zone)                                     | The zone to host the cluster in (required if is a zonal cluster) | `string` | `"us-central1-a"`                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   |    no    |

## Outputs

No outputs.

<!-- END_TF_DOCS -->
