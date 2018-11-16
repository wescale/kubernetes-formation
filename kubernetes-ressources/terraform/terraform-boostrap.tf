terraform {
  backend "gcs" {
    bucket  = "sandbox-wescale-terraform-states"
    prefix  = "kubernetes-formation"
    project = "sandbox-wescale"
    region = "europe-west1"
  }
}

module "bootstrap-training" {
  MOD_JSON_PATH       = "sandbox-wescale.json"
  MOD_PROJECT         = "sandbox-wescale"
  MOD_REGION          = "europe-west1"
  MOD_COUNT           = 8

  source = "modules"
}
