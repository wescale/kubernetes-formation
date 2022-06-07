variable "dns_zone_id" {
  description = "The DNS zone id where bastion FQDN must be recorded."
}

variable "dns_zone_domain" {
  description = "The DNS zone domain where bastion FQDN must be recorded."
}

resource "google_compute_instance" "training-instance" {
  count        = var.MOD_COUNT
  name         = "training-instance-${count.index}"
  machine_type = "g1-small"
  zone         = "${var.MOD_REGION}-b"

  boot_disk {
    initialize_params {
      image = "projects/ubuntu-os-cloud/global/images/ubuntu-2004-focal-v20220308"
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

resource "aws_route53_record" "bastion" {
  zone_id = var.dns_zone_id
  name = "bastion.${var.dns_zone_domain}"
  type = "A"

  records = [ google_compute_instance.training-instance[0].network_interface.0.access_config.0.nat_ip]
  ttl = 60

  lifecycle {
    create_before_destroy = false
  }
}