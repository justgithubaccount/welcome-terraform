output "pfsense_instance_ip" {
  value = yandex_compute_instance.pfsense_instance.network_interface.0.nat_ip_address
}

output "app_compose_internal_ip" {
  value = yandex_compute_instance.app_compose.network_interface.0.ip_address
}

output "prometheus_internal_ip" {
  value = yandex_compute_instance.prometheus.network_interface.0.ip_address
}

output "srv_runner_internal_ip" {
  value = yandex_compute_instance.srv_runner.network_interface.0.ip_address
}
