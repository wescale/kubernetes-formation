resource "google_container_cluster" "training-cluster" {
  count        = var.MOD_COUNT
  name         = "training-cluster-${count.index}"
  location         = "${var.MOD_REGION}-b"
  initial_node_count = 3


  network = google_compute_network.training_net.name
  subnetwork = google_compute_subnetwork.training_subnet.name

  node_config {
    oauth_scopes = [
      "https://www.googleapis.com/auth/compute",
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]
  }
}