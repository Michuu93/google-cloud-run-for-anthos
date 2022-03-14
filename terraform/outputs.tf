output "region" {
  value       = var.gcp_region
  description = "GCloud Region"
}

output "project_id" {
  value       = var.gcp_project
  description = "GCloud Project ID"
}

output "kubernetes_cluster_machine_type" {
  value       = var.machine_type
  description = "GKE Cluster Machine Type"
}
