data "google_compute_default_service_account" "default" {
}

resource "google_service_account" "k8s_fundamentals" {
  account_id   = "k8s-fundamentals"
  display_name = "k8s fundamentals Service Account"
}

resource "google_service_account_iam_member" "use-role-on-node" {
  service_account_id = data.google_compute_default_service_account.default.id
  role               = "roles/iam.serviceAccountUser"
  member             = "serviceAccount:${google_service_account.k8s_fundamentals.email}"
}

resource "google_project_iam_member" "gke-admin" {
  role               = "roles/container.admin"
  member             = "serviceAccount:${google_service_account.k8s_fundamentals.email}"
}

resource "google_project_iam_member" "project-viewer" {
  role               = "roles/viewer"
  member             = "serviceAccount:${google_service_account.k8s_fundamentals.email}"
}

