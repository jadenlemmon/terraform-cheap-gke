# Cheap GKE Cluster Terraform Module

Creating a GKE cluster in GCP often leaves you with default settings that aren't cost-effective. It's fair to say, for the purpose of creating clusters for testing and development, there's no need for features like multi-region, high availability, load balancers, and so on.

This module gives you a simple, no-fuss way to set up a GKE cluster that's optimized for development purposes. It's a result of extensive research to find a cost-effective solution.

Among all GCP regions, `us-central1` offers the most economical rates.

Spot instances are another way to trim your budget, offering a substantial discount of around 75% or more when compared to standard instances. By default, we utilize two node pools. The first, named ingress, operates on a single e2-small instance, serving as a budget-friendly load balancer. To ensure uninterrupted operation, this instance does not run on spot instances. The second node pool, shared, is configured to handle all additional workloads using spot instances.
