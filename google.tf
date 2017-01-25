
// This configures the Google Cloud provider
provider "google" {
  credentials = "${file("../account.json")}"
  project     = "sinuous-country-156711"
  region      = "asia-northeast1"
}

// I now want to create an instance

resource "google_compute_disk" "yolo" {
  name	= "test-disk"
  type	= "pd-ssd"
  zone	= "asia-northeast1-c"
  size	= 80
}

resource "google_compute_instance" "default" {
  name         = "terraform-instance"
  machine_type = "custom-4-16384"	#(To create a custom machiene with 2 CPUs and 16GB of memory)
  zone         = "asia-northeast1-c"

  description = "A GCE VM setup with terraform"
  
  disk {
    image = "ubuntu-os-cloud/ubuntu-1604-lts" # image-project/image-family
  }

  disk {
    disk = "test-disk"
  }

  tags = ["browser-apps"]

  network_interface {
    network = "default"
  access_config {	# This allows you to ssh into the machiene which is of course very useful!
    }
  }

  metadata_startup_script = "${file("bootstrap.sh")}"
  
}
