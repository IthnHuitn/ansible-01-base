output "clickhouse_ip" {
  description = "External IP of ClickHouse VM"
  value       = yandex_compute_instance.clickhouse.network_interface[0].nat_ip_address
}

output "vector_ip" {
  description = "External IP of Vector VM"
  value       = yandex_compute_instance.vector.network_interface[0].nat_ip_address
}

output "lighthouse_ip" {
  description = "External IP of Lighthouse VM"
  value       = yandex_compute_instance.lighthouse.network_interface[0].nat_ip_address
}

output "clickhouse_internal_ip" {
  description = "Internal IP of ClickHouse VM"
  value       = yandex_compute_instance.clickhouse.network_interface[0].ip_address
}

output "vector_internal_ip" {
  description = "Internal IP of Vector VM"
  value       = yandex_compute_instance.vector.network_interface[0].ip_address
}

output "lighthouse_internal_ip" {
  description = "Internal IP of Lighthouse VM"
  value       = yandex_compute_instance.lighthouse.network_interface[0].ip_address
}