terraform {
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = "~> 0.100"
    }
  }
}

provider "yandex" {
  cloud_id                 = var.cloud_id
  folder_id                = var.folder_id
  zone                     = var.zone
  service_account_key_file = var.service_account_key_file
}

data "yandex_compute_image" "almalinux" {
  family = "almalinux-10"
}

resource "yandex_compute_instance" "clickhouse" {
  name        = "clickhouse-01"
  hostname    = "clickhouse-01"
  platform_id = var.platform_id
  zone        = var.zone

  resources {
    cores         = var.cores
    memory        = var.memory
    core_fraction = var.core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.almalinux.id
      size     = var.disk_size
    }
  }

  network_interface {
    subnet_id          = var.subnet_id
    nat                = true
    security_group_ids = [var.security_group_id]
  }

  metadata = {
    ssh-keys = "almalinux:${file(var.public_key_path)}"
  }

  scheduling_policy {
    preemptible = var.preemptible
  }
}

resource "yandex_compute_instance" "vector" {
  name        = "vector-01"
  hostname    = "vector-01"
  platform_id = var.platform_id
  zone        = var.zone

  resources {
    cores         = var.cores
    memory        = var.memory
    core_fraction = var.core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.almalinux.id
      size     = var.disk_size
    }
  }

  network_interface {
    subnet_id          = var.subnet_id
    nat                = true
    security_group_ids = [var.security_group_id]
  }

  metadata = {
    ssh-keys = "cloud-user:${file(var.public_key_path)}"
  }

  scheduling_policy {
    preemptible = var.preemptible
  }
}