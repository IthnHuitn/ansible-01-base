variable "cloud_id" {
  description = "Yandex Cloud ID"
  type        = string
}

variable "folder_id" {
  description = "Yandex Cloud Folder ID"
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID"
  type        = string
}

variable "security_group_id" {
  description = "Security Group ID"
  type        = string
}

variable "service_account_key_file" {
  description = "Path to service account key file"
  type        = string
}

variable "public_key_path" {
  description = "Path to public SSH key"
  type        = string
}

variable "platform_id" {
  description = "VM platform"
  type        = string
  default     = "standard-v2"
}

variable "cores" {
  description = "CPU cores"
  type        = number
  default     = 2
}

variable "memory" {
  description = "RAM in GB"
  type        = number
  default     = 2
}

variable "core_fraction" {
  description = "CPU fraction"
  type        = number
  default     = 20
}

variable "disk_size" {
  description = "Boot disk size in GB"
  type        = number
  default     = 10
}

variable "preemptible" {
  description = "Use preemptible VM"
  type        = bool
  default     = true
}

variable "zone" {
  description = "Yandex Cloud zone"
  type        = string
  default     = "ru-central1-a"
}