variable "gcp_credentials" {
  type        = string
  description = "Location of the service account for GCP."
}

variable "gcp_project_id" {
  type        = string
  description = "GCP project id to create the resources."
}

variable "gcp_region" {
  type        = string
  description = "The GCP region to create the resources."
  default     = "us-central1"
}
variable "cluster_name" {
  type        = string
  description = "The name of the cluster, unique within the project and location."
  default     = "primary"
}
variable "master_ipv4_cidr_block" {
  type        = string
  description = "The IP range in CIDR notation to use for the hosted master network."
  default     = "172.16.0.0/28"
}
variable "router_nat_name" {
  type        = string
  description = "Name of the NAT service."
  default     = "nat"
}
variable "compute_address_name" {
  type        = string
  description = " Name of the resource."
  default     = "nat"
}
variable "service_account_name" {
  type        = string
  description = "Name of the resource."
  default     = "kubernetes"
}
