variable "gcp_project" {}
variable "location" {}
variable "network" {}
variable "subnetwork" {}
variable "preemptible" {
  default = true
}
variable "machine_type" {
  # Anthos Service Mesh requires machine type with at least 4 vCPUs, such as e2-standard-4
  default = "e2-standard-4"
}
