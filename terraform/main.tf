provider "google" {
  project = var.gcp_project
  region  = var.gcp_region
}

# Enable Kubernetes Engine API
resource "google_project_service" "container" {
  project = var.gcp_project
  service = "container.googleapis.com"
}

# Enable Compute Engine API
resource "google_project_service" "compute" {
  project = var.gcp_project
  service = "compute.googleapis.com"
}

module "vpc" {
  source      = "./modules/vpc"
  gcp_project = var.gcp_project
  gcp_region  = var.gcp_region
  depends_on  = [google_project_service.compute]
}

module "gke" {
  source       = "./modules/gke"
  gcp_project  = var.gcp_project
  gcp_region   = var.gcp_region
  machine_type = var.machine_type
  depends_on   = [google_project_service.compute, google_project_service.container]
}
