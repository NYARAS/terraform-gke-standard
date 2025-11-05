output "k8s_service_account_names" {
  description = "List of Kubernetes service account names used in the namespaces."
  value       = [for ns in var.namespaces : local.k8s_given_name]
}

output "k8s_service_account_namespaces" {
  description = "List of Kubernetes namespaces where the service accounts exist."
  value       = var.namespaces
}

output "gcp_service_account_email" {
  description = "Email address of the GCP service account."
  value       = local.gcp_sa_email
}

output "gcp_service_account_fqn" {
  description = "Fully qualified GCP service account identity (for IAM bindings)."
  value       = "serviceAccount:${local.gcp_sa_email}"
}

output "gcp_service_account_workload_identity_members" {
  description = "List of Kubernetes service account identities bound to the GCP service account for Workload Identity."
  value       = local.k8s_sa_gcp_derived_names
}
