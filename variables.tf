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
  default     = "us-west1"
}
