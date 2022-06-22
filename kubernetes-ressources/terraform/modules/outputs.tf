output bastion_ip {
  value = google_compute_instance.training-instance[0].network_interface.0.access_config.0.nat_ip
}

output dns_record {
  value = aws_route53_record.bastion.fqdn
}

output password {
  // replace , for CSV files
  value = replace(random_password.password.result, ",", "_")
  sensitive = true
}