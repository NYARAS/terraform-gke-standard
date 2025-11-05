variable "name" {
  description = "Base name for the service accounts"
  type        = string
}

variable "project_id" {
  description = "GCP project ID"
  type        = string
}

variable "namespaces" {
  description = "List of Kubernetes namespaces to bind to the same GCP service account"
  type        = list(string)
  default     = ["default"]
}

variable "k8s_sa_name" {
  description = "Name of existing Kubernetes service account (shared across all namespaces if provided)"
  type        = string
  default     = null
}

variable "use_existing_k8s_sa" {
  description = "Use existing Kubernetes service accounts instead of creating them"
  type        = bool
  default     = false
}
