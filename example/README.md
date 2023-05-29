# Cheap GKE Example

This example creates a new GCP project, enables the necessary APIs, and provisions a new GKE cluster with the Cheap GKE module.

## Getting Started

Set some env vars

```sh
export TF_VAR_org_id=xxxxx
export TF_VAR_project_id=xxxxx
export TF_VAR_billing_account_id=xxxxx
```

Initialize Terraform

```sh
terraform init
```

Apply Terraform

```sh
terraform apply
```
