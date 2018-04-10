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
    ssh-keys = "training:ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDRu/6NgZXgc8A2d+BX2gjsiGK+SHzxNeLevi2Xkr02/laqcFcbQ4hmZLd4S5oxAr+xN1r7GCE/WZOHOiXWe2j6RElroMMpi4RW0kkxqDicTLlQzgTqejB2rgM3kN3WLmQNn6tW5CuWPNcQecPkp/8WuXIEmiSK+y6CvFDUgfdgYbJPKQnI6pgkkTa+QFRPKqQl9gtId8L6b8asnUUJ/fADUzLmgesx3kvjJLwV73iMfIQ0GFuCo6NJ0wgSyhoJMzzcbk/El1q0AZKFW+24+HKa4Rlza7mccceShHNbr7OXt0zekwSkTA2Q4GILsuPA0rv07ZgmUfEXfeOUGFzuYb8B slavayssiere@Sebastiens-MBP"
  }

  service_account {
    scopes = ["https://www.googleapis.com/auth/cloud-platform", "compute-rw", "storage-rw"]
  }

  metadata_startup_script = "curl -s https://raw.githubusercontent.com/WeScale/kubernetes-formation/master/terraform/modules/bootstrap-vm.sh | bash -s ${count.index}"
}
