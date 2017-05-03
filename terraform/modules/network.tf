resource "google_compute_network" "training_net" {
  name       = "training-net"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "training_subnet" {
  name          = "training-subnet"
  ip_cidr_range = "10.123.0.0/24"
  network       = "${google_compute_network.training_net.self_link}"
  region        = "${var.MOD_REGION}"
}


resource "google_compute_firewall" "training_fw_rules" {
  name    = "training-fw-rules"
  network = "${google_compute_network.training_net.name}"

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
  }

  allow {
    protocol = "udp"
  }
}
