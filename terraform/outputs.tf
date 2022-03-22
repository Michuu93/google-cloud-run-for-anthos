output "region" {
  value       = var.gcp_region
  description = "GCloud Region"
}

output "zone" {
  value       = var.gcp_zone
  description = "GCloud Zone"
}

output "project_id" {
  value       = var.gcp_project
  description = "GCloud Project ID"
}

# VPC module
output "google_compute_network_name" {
  value       = module.vpc.google_compute_network_name
  description = "Network name"
}

output "google_compute_subnetwork_name" {
  value       = module.vpc.google_compute_subnetwork_name
  description = "Subnet name"
}

# GKE module
output "kubernetes_cluster_name" {
  value       = module.gke.kubernetes_cluster_name
  description = "GKE Cluster Name"
}

output "kubernetes_cluster_host" {
  value       = module.gke.kubernetes_cluster_host
  description = "GKE Cluster Host"
}

output "kubernetes_cluster_machine_type" {
  value       = module.gke.kubernetes_cluster_machine_type
  description = "GKE Cluster Machine Type"
}

output "kubernetes_node_pool_type" {
  value       = module.gke.kubernetes_node_pool_type
  description = "GKE Node Pool Type"
}

output "kubernetes_location" {
  value       = module.gke.kubernetes_location
  description = "GKE Location"
}

output "kubernetes_service_account" {
  value       = module.gke.kubernetes_service_account
  description = "GKE Service Account"
}
