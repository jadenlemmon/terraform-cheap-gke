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

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | n/a |
| <a name="provider_google-beta"></a> [google-beta](#provider\_google-beta) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google-beta_google_compute_address.static-ingress](https://registry.terraform.io/providers/hashicorp/google-beta/latest/docs/resources/google_compute_address) | resource |
| [google-beta_google_container_cluster.default](https://registry.terraform.io/providers/hashicorp/google-beta/latest/docs/resources/google_container_cluster) | resource |
| [google_compute_firewall.default](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_firewall) | resource |
| [google_compute_network.default](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_network) | resource |
| [google_compute_router.router](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_router) | resource |
| [google_compute_router_nat.nat](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_router_nat) | resource |
| [google_compute_subnetwork.default](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_subnetwork) | resource |
| [google_container_node_pool.node-pools](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/container_node_pool) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cluster_ipv4_cidr_block"></a> [cluster\_ipv4\_cidr\_block](#input\_cluster\_ipv4\_cidr\_block) | The CIDR range for the cluster pods | `string` | `"10.2.0.0/18"` | no |
| <a name="input_cluster_subnetwork_cidr_range"></a> [cluster\_subnetwork\_cidr\_range](#input\_cluster\_subnetwork\_cidr\_range) | The CIDR range for the cluster subnetwork | `string` | `"10.0.0.0/24"` | no |
| <a name="input_disk_size"></a> [disk\_size](#input\_disk\_size) | The disk size of the cluster nodes | `number` | `20` | no |
| <a name="input_gke_cluster_name"></a> [gke\_cluster\_name](#input\_gke\_cluster\_name) | The name of the cluster | `string` | `"gke-cheap-cluster"` | no |
| <a name="input_master_ipv4_cidr_block"></a> [master\_ipv4\_cidr\_block](#input\_master\_ipv4\_cidr\_block) | The CIDR range for the master nodes | `string` | `"10.1.0.0/28"` | no |
| <a name="input_network_name"></a> [network\_name](#input\_network\_name) | The name of the network | `string` | `"gke-cluster-network"` | no |
| <a name="input_node_pools"></a> [node\_pools](#input\_node\_pools) | n/a | `map` | <pre>{<br>  "ingress": {<br>    "auto_repair": true,<br>    "auto_upgrade": true,<br>    "disk_size_gb": 10,<br>    "disk_type": "pd-standard",<br>    "initial_node_count": 1,<br>    "machine_type": "e2-small",<br>    "max_node_count": 1,<br>    "min_node_count": 1,<br>    "spot": true,<br>    "tags": [<br>      "ingress"<br>    ],<br>    "taints": [<br>      {<br>        "effect": "NO_EXECUTE",<br>        "key": "ingress",<br>        "value": true<br>      }<br>    ]<br>  },<br>  "shared": {<br>    "auto_repair": true,<br>    "auto_upgrade": true,<br>    "disk_size_gb": 20,<br>    "disk_type": "pd-standard",<br>    "initial_node_count": 1,<br>    "machine_type": "e2-small",<br>    "max_node_count": 5,<br>    "min_node_count": 1,<br>    "spot": true,<br>    "tags": [<br>      "shared"<br>    ],<br>    "taints": []<br>  }<br>}</pre> | no |
| <a name="input_num_nodes"></a> [num\_nodes](#input\_num\_nodes) | The number of cluster nodes | `number` | `1` | no |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | The project ID to host the cluster in | `any` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | The region to host the cluster in | `string` | `"us-central1"` | no |
| <a name="input_services_ipv4_cidr_block"></a> [services\_ipv4\_cidr\_block](#input\_services\_ipv4\_cidr\_block) | The CIDR range for the cluster services | `string` | `"10.3.0.0/18"` | no |
| <a name="input_zone"></a> [zone](#input\_zone) | The zone to host the cluster in (required if is a zonal cluster) | `string` | `"us-central1-a"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_google_container_cluster"></a> [google\_container\_cluster](#output\_google\_container\_cluster) | n/a |
<!-- END_TF_DOCS -->
