resource "google_service_account" "cluster_service_account" {
  account_id   = var.name
  display_name = substr("GCP SA bound to K8S SAs ${local.k8s_given_name}", 0, 100)
  project      = var.project_id
}

resource "kubernetes_service_account" "main" {
  for_each = var.use_existing_k8s_sa ? toset([]) : local.normalized_namespaces

  metadata {
    name      = var.name
    namespace = each.key
    annotations = {
      "iam.gke.io/gcp-service-account" = google_service_account.cluster_service_account.email
    }
  }
}
