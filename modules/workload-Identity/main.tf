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

module "annotate_sa" {
  source  = "terraform-google-modules/gcloud/google"
  version = "~> 4.0"

  for_each = var.use_existing_k8s_sa ? local.normalized_namespaces : toset([])

  platform              = "linux"
  enabled               = true
  skip_download         = true
  additional_components = ["kubectl"]

  create_cmd_entrypoint = "bash"
  create_cmd_body       = <<-EOT
    set +e
    kubectl annotate sa -n "${each.key}" "${local.k8s_given_name}" \
      iam.gke.io/gcp-service-account="${local.gcp_sa_email}" \
      --overwrite --ignore-not-found || true
    exit 0
  EOT

  destroy_cmd_entrypoint = "bash"
  destroy_cmd_body       = <<-EOT
    set +e
    kubectl annotate sa -n "${each.key}" "${local.k8s_given_name}" \
      iam.gke.io/gcp-service-account- \
      --overwrite --ignore-not-found || true
    exit 0
  EOT
}

resource "google_service_account_iam_member" "main" {
  for_each = toset(local.k8s_sa_gcp_derived_names)

  service_account_id = google_service_account.cluster_service_account.name
  role               = "roles/iam.workloadIdentityUser"
  member             = each.key
}
