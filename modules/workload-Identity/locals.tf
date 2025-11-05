locals {
  k8s_given_name = var.k8s_sa_name != null ? var.k8s_sa_name : var.name

  # Create workload identity member strings for each namespace
  k8s_sa_gcp_derived_names = [
    for ns in var.namespaces :
    "serviceAccount:${var.project_id}.svc.id.goog[${ns}/${local.k8s_given_name}]"
  ]

  gcp_sa_email          = google_service_account.cluster_service_account.email
  normalized_namespaces = toset(sort(var.namespaces))
}
