variable "MOD_JSON_PATH" {
}

variable "MOD_PROJECT" {
}

variable "MOD_REGION" {
}

variable "MOD_COUNT" {
}

provider "google" {
  credentials = "${file("${var.MOD_JSON_PATH}")}"
  project     = "${var.MOD_PROJECT}"
  region      = "${var.MOD_REGION}"
}
