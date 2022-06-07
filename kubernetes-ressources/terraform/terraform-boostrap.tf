terraform {
  backend "gcs" {
    bucket = "wsc-training-tfstates"
    prefix = "k8s-training-niv-1" //project = "wsc-training-deploy"
  }
}

provider "google" {
  project     = terraform.workspace
  region      = "europe-west1"
  alias = "default"
}

provider "aws" {
  region = "eu-west-1"
}

data "aws_route53_zone" "main" {
 name = "wescaletraining.fr"
}

locals{
  training_number = trimprefix(terraform.workspace, "wsc-kubernetes-training-")
  dns_zone_domain =  "fund-${local.training_number}.${data.aws_route53_zone.main.name}"
}

module "bootstrap-training" {
  /*providers = {
    google = google.default
  }*/

  MOD_REGION    = "europe-west1"
  MOD_COUNT     = 1
  MOD_PROJECT = terraform.workspace

  dns_zone_id = data.aws_route53_zone.main.zone_id
  dns_zone_domain = local.dns_zone_domain

  source = "./modules"
}


output bastion_ip {
  value = module.bootstrap-training.bastion_ip
}

output password {
  value = module.bootstrap-training.password
  sensitive = true
}