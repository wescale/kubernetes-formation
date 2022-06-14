resource "google_compute_instance" "training-instance" {
  count        = var.MOD_COUNT
  name         = "training-instance-${count.index}"
  machine_type = "g1-small"
  zone         = "${var.MOD_REGION}-b"

  boot_disk {
    initialize_params {
      image = "projects/ubuntu-os-cloud/global/images/ubuntu-2010-groovy-v20210511a"
      type = "pd-standard"
      size = "15" # ie 15GB
    }
    auto_delete = true
  }

  network_interface {
    subnetwork = google_compute_subnetwork.training_subnet.name
    access_config {
      # Ephemeral
    }
  }

  metadata = {
    ssh-keys = "training:${file("${path.cwd}/kubernetes-formation.pub")}"
  }

  service_account {
    email = google_service_account.k8s_fundamentals.email
    scopes = ["cloud-platform"]
  }

  allow_stopping_for_update = true

  metadata_startup_script = "curl -s https://raw.githubusercontent.com/WeScale/kubernetes-formation/master/kubernetes-ressources/terraform/modules/bootstrap-vm.sh | bash -s ${count.index}"
}