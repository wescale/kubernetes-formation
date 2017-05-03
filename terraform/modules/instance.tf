resource "google_compute_instance" "training-instance" {
  count        = "${var.MOD_COUNT}"
  name         = "training-instance-${count.index}"
  machine_type = "g1-small"
  zone         = "${var.MOD_REGION}-b"

  disk {
    image = "ubuntu-1610-yakkety-v20170330"
    type = "pd-ssd"
    size = "10" # ie 10GB
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

  metadata_startup_script = "curl -s https://gist.githubusercontent.com/cedbossneo/9e331a8136a37a7304051d4fa730bc14/raw/287ca7454fc4957b06fba24aec072fddb99a4cc9/bootstrap.sh | bash -s ${count.index}"
}
