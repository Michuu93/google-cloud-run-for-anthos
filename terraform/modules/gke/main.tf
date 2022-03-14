resource "google_service_account" "default" {
  account_id   = "gke-service-account-id"
  display_name = "GKE Service Account"
  description  = "Service Account for GKE and Cloud Run For Anthos"
}

resource "google_container_cluster" "primary" {
  name     = "${var.gcp_project}-anthos-gke"
  location = var.gcp_region

  # We can't create a cluster with no node pool defined, but we want to only use
  # separately managed node pools. So we create the smallest possible default
  # node pool and immediately delete it.
  remove_default_node_pool = true
  initial_node_count       = 1

  addons_config {
    cloudrun_config {
      disabled = false
    }
  }
}

resource "google_container_node_pool" "primary_preemptible_nodes" {
  name       = "${var.gcp_project}-anthos-node-pool"
  location   = var.gcp_region
  cluster    = google_container_cluster.primary.name
  node_count = 1

  node_config {
    preemptible  = true
    machine_type = var.machine_type

    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    service_account = google_service_account.default.email
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }

  # It is recommended that node pools be created and managed as separate resources as in the example above.
  # This allows node pools to be added and removed without recreating the cluster.
  # Node pools defined directly in the google_container_cluster resource cannot be removed without re-creating the cluster.
}
