---
clickhouse:
  hosts:
    clickhouse-01:
      ansible_host: ${clickhouse_ip}
      ansible_user: almalinux
      ansible_ssh_private_key_file: /home/evilmc/.ssh/vm5
      ansible_ssh_common_args: '-o StrictHostKeyChecking=no'

vector:
  hosts:
    vector-01:
      ansible_host: ${vector_ip}
      ansible_user: almalinux
      ansible_ssh_private_key_file: /home/evilmc/.ssh/vm5
      ansible_ssh_common_args: '-o StrictHostKeyChecking=no'