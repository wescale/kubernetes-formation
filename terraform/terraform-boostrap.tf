module "bootstrap-training" {
  MOD_JSON_PATH       = "sandbox-wescale-3b00dc1686b7.json"
  MOD_PROJECT         = "sandbox-wescale"
  MOD_REGION          = "europe-west1"
  MOD_COUNT           = 9

  source = "modules"
}
