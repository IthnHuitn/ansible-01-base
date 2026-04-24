output "clickhouse_ip" {
  description = "External IP of ClickHouse VM"
  value       = yandex_compute_instance.clickhouse.network_interface[0].nat_ip_address
}

output "vector_ip" {
  description = "External IP of Vector VM"
  value       = yandex_compute_instance.vector.network_interface[0].nat_ip_address
}

output "clickhouse_internal_ip" {
  description = "Internal IP of ClickHouse VM"
  value       = yandex_compute_instance.clickhouse.network_interface[0].ip_address
}

output "vector_internal_ip" {
  description = "Internal IP of Vector VM"
  value       = yandex_compute_instance.vector.network_interface[0].ip_address
}

output "inventory" {
  description = "Ansible inventory"
  value = templatefile("${path.module}/inventory.tpl", {
    clickhouse_ip = yandex_compute_instance.clickhouse.network_interface[0].nat_ip_address
    vector_ip     = yandex_compute_instance.vector.network_interface[0].nat_ip_address
  })
}