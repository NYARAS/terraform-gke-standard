resource "google_service_account" "kubernetes" {
  account_id = var.service_account_name
}

# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/container_node_pool
resource "google_container_node_pool" "general" {
  name               = "general"
  cluster            = google_container_cluster.primary.id
  initial_node_count = var.initial_node_count

  management {
    auto_repair  = true
    auto_upgrade = true
  }

  autoscaling {
    min_node_count = var.min_node_count
    max_node_count = var.max_node_count
  }

  node_config {
    preemptible  = false
    machine_type = var.node_pools_machine_type

    labels = {
      role = "general"
    }

    service_account = google_service_account.kubernetes.email
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
}
