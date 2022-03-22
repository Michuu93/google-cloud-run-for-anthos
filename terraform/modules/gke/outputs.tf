output "kubernetes_cluster_name" {
  value       = google_container_cluster.anthos-gke-cluster.name
  description = "GKE Cluster Name"
}

output "kubernetes_cluster_host" {
  value       = google_container_cluster.anthos-gke-cluster.endpoint
  description = "GKE Cluster Host"
}

output "kubernetes_cluster_machine_type" {
  value       = var.machine_type
  description = "GKE Cluster Machine Type"
}

output "kubernetes_node_pool_type" {
  value       = var.preemptible
  description = "GKE Node Pool Type"
}

output "kubernetes_location" {
  value       = var.location
  description = "GKE Location"
}

output "kubernetes_service_account" {
  value       = google_service_account.gke-service-account.email
  description = "GKE Service Account"
}
