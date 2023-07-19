locals {
  apis = [
    "container.googleapis.com",
    "compute.googleapis.com",
    "iam.googleapis.com",
  ]
}

resource "google_project" "project" {
  name            = var.project_id
  project_id      = var.project_id
  org_id          = var.org_id
  billing_account = var.billing_account_id
}

resource "google_project_service" "project-apis" {
  for_each           = toset(local.apis)
  project            = var.project_id
  service            = each.value
  disable_on_destroy = false
}
