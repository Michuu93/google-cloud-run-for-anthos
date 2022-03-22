# Service Account
# Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
resource "google_service_account" "gke-service-account" {
  project      = var.gcp_project
  account_id   = "gke-service-account-id"
  display_name = "GKE Service Account"
  description  = "Service Account for GKE with Anthos"
}

# GKE Cluster without default node pool
resource "google_container_cluster" "anthos-gke-cluster" {
  provider = google-beta
  name     = "anthos-gke-cluster"
  project  = var.gcp_project
  location = var.location

  # We can't create a cluster with no node pool defined, but we want to only use
  # separately managed node pools. So we create the smallest possible default
  # node pool and immediately delete it.
  remove_default_node_pool = true
  initial_node_count       = 1

  network    = var.network
  subnetwork = var.subnetwork

  workload_identity_config {
    identity_namespace = "${var.gcp_project}.svc.id.goog"
  }
}

# GKE custom node pool
# It is recommended that node pools be created and managed as separate resources as in the example above.
# This allows node pools to be added and removed without recreating the cluster.
# Node pools defined directly in the google_container_cluster resource cannot be removed without re-creating the cluster.
resource "google_container_node_pool" "anthos_nodes" {
  provider   = google-beta
  name       = "anthos-node-pool"
  project    = var.gcp_project
  location   = var.location
  cluster    = google_container_cluster.anthos-gke-cluster.name
  node_count = 1

  node_config {
    preemptible     = var.preemptible
    machine_type    = var.machine_type
    service_account = google_service_account.gke-service-account.email
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }

  depends_on = [
    google_service_account.gke-service-account,
    google_container_cluster.anthos-gke-cluster
  ]
}

# GKE Hub Membership
resource "google_gke_hub_membership" "gke-anthos-membership" {
  provider      = google-beta
  project       = var.gcp_project
  membership_id = "gke-anthos-membership"

  endpoint {
    gke_cluster {
      resource_link = "//container.googleapis.com/${google_container_cluster.anthos-gke-cluster.id}"
    }
  }

  authority {
    issuer = "https://container.googleapis.com/v1/${google_container_cluster.anthos-gke-cluster.id}"
  }
}
