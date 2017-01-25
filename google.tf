
// This configures the Google Cloud provider
provider "google" {
  credentials = "${file("account.json")}"
  project     = "sinuous-country-156711"
  region      = "asia-northeast1"
}

// I now want to create an instance

resource "google_compute_instance" "default" {
  name         = "terraform-instance"
  machine_type = "n1-standard-1"
  zone         = "asia-northeast1-c"

  tags = ["foo", "bar"]

  disk {
    image = "debian-cloud/debian-8"
  }

  // Local SSD disk
  disk {
    type    = "local-ssd"
    scratch = true
  }

  network_interface {
    network = "default"
    access_config {
      // Ephemeral IP
    }
  }

  metadata {
    foo = "bar"
  }

  metadata_startup_script = "echo hi > /test.txt"

  service_account {
    scopes = ["userinfo-email", "compute-ro", "storage-ro"]
  }
}
