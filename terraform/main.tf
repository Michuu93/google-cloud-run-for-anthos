provider "google-beta" {
  project = var.gcp_project
  region  = var.gcp_region
}

# Enable Kubernetes Engine API
resource "google_project_service" "gke" {
  project = var.gcp_project
  service = "container.googleapis.com"
}

# Enable Compute Engine API
resource "google_project_service" "compute" {
  project = var.gcp_project
  service = "compute.googleapis.com"
}

# Enable Anthos API
resource "google_project_service" "anthos" {
  project = var.gcp_project
  service = "anthos.googleapis.com"
}

# Enable Cloud Build API
resource "google_project_service" "cloudbuild" {
  project = var.gcp_project
  service = "cloudbuild.googleapis.com"
}

# Enable Container Registry API
resource "google_project_service" "containerregistry" {
  project = var.gcp_project
  service = "containerregistry.googleapis.com"
}

module "vpc" {
  source      = "./modules/vpc"
  gcp_project = var.gcp_project
  gcp_region  = var.gcp_region
  depends_on  = [google_project_service.compute]
}

module "gke" {
  source      = "./modules/gke"
  gcp_project = var.gcp_project
  location    = var.gcp_zone
  network     = module.vpc.google_compute_network_name
  subnetwork  = module.vpc.google_compute_subnetwork_name
  depends_on = [
    module.vpc,
    google_project_service.compute,
    google_project_service.gke,
    google_project_service.anthos,
    google_project_service.cloudbuild,
    google_project_service.containerregistry
  ]
}
