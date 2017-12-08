resource "google_compute_instance" "training-instance" {
  count        = "${var.MOD_COUNT}"
  name         = "training-instance-${count.index}"
  machine_type = "g1-small"
  zone         = "${var.MOD_REGION}-b"

  boot_disk {
    initialize_params {
      image = "projects/ubuntu-os-cloud/global/images/ubuntu-1710-artful-v20171122"
      type = "pd-standard"
      size = "10" # ie 10GB
    }
    auto_delete = true
  }

  network_interface {
    subnetwork = "${google_compute_subnetwork.training_subnet.name}"
    access_config {
      # Ephemeral
    }
  }

  metadata {
    ssh-keys = "training:ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDiZOht7hDWIomDFom83ecX0ZzGP0dVaJoBWzBKUeqUyR3oagwICCBybKw4tthwBG8jimx+vd8P6fEvJwVIzfBG1kPsmjtACLa9Dnox+m4mvBib3X7FC+3Uo2JEbmIbiRpmjm7JhK1hFdMgn06I2qywBTXrPUPRA6M1zdCABDF+Lfafmq3RObBj5TpNx0yWY7r9iBy7V/VE4U+EiDaih57Vhx7cyeBQ7XiGPUbjKAfsFaDHxGl3YOAywQu+Ur977vCblCY2fWXZfrNzqRzkz/dM4p9dJnfoCwVVX1kYJl60c75EU9chS3Jes6XaW7ae309jcUksW6N10LHJD+50CHE3 training@gemalto"
  }

  service_account {
    scopes = ["https://www.googleapis.com/auth/cloud-platform", "compute-rw", "storage-rw"]
  }

  metadata_startup_script = "curl -s https://raw.githubusercontent.com/WeScale/kubernetes-formation/master/terraform/modules/bootstrap-vm.sh | bash -s ${count.index}"
}
