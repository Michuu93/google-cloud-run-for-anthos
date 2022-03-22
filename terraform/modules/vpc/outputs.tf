output "google_compute_network_name" {
  value       = google_compute_network.vpc.name
  description = "Network name"
}

output "google_compute_subnetwork_name" {
  value       = google_compute_subnetwork.subnet.name
  description = "Subnet name"
}
