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

variable "dns_prefix" {
  type = string
  default = "fund"
  description = "Prefix des URLs Route53. Ex: 'fund' dans fund-1.wescaletraining.fr"
}

data "aws_route53_zone" "main" {
 name = "wescaletraining.fr"
}

locals{
  training_number = regex("^.*-(\\d+)$", terraform.workspace) # Récupère le nombre à la fin du workspace
  dns_zone_domain = "${var.dns_prefix}-${local.training_number[0]}.${data.aws_route53_zone.main.name}"
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

output bastion_dns {
  value = module.bootstrap-training.dns_record
}

output password {
  value = module.bootstrap-training.password
  sensitive = true
}
