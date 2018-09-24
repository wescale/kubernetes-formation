module "bootstrap-training" {
  MOD_JSON_PATH       = "sandbox-wescale.json"
  MOD_PROJECT         = "sandbox-wescale"
  MOD_REGION          = "europe-west1"
  MOD_COUNT           = 11

  source = "modules"
}
