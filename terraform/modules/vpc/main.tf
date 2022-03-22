# VPC
resource "google_compute_network" "vpc" {
  name                    = "${var.gcp_project}-vpc"
  project                 = var.gcp_project
  auto_create_subnetworks = "false"
}

# Subnet
resource "google_compute_subnetwork" "subnet" {
  name          = "${var.gcp_project}-subnet"
  project       = var.gcp_project
  region        = var.gcp_region
  network       = google_compute_network.vpc.name
  ip_cidr_range = "10.10.0.0/24"
}
