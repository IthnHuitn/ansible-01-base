# Домашнее задание к занятию 3 «Использование Ansible» - `Ефимов Вячеслав`

# Ansible Playbook: ClickHouse + Vector + Lighthouse

Автоматическое развертывание ClickHouse, Vector и Lighthouse на AlmaLinux 10 в Яндекс Облаке.

## Описание

Playbook автоматизирует установку и настройку:
- **ClickHouse** — колоночная аналитическая СУБД (порт 9000, 8123)
- **Vector** — сборщик и трансформатор логов (отправка демо-логов в ClickHouse)
- **Lighthouse** — веб-интерфейс для ClickHouse (Nginx + статика)

### Архитектура

[Vector] ---логи---> [ClickHouse] <---запросы--- [Lighthouse]
:8123 :9000, :8123 :80

## Структура проекта

ansible-03-yandex/
├── terraform/ # Terraform для Yandex Cloud
│ ├── main.tf # Конфигурация 3 ВМ
│ ├── variables.tf # Переменные
│ ├── terraform.tfvars.example # Пример переменных
│ └── outputs.tf # IP адреса
├── playbook/ # Ansible
│ ├── inventory/
│ │ └── prod.yml # Инвентарь хостов
│ ├── group_vars/
│ │ ├── lighthouse/vars.yml # хост ClickHouse
│ │ ├── clickhouse/vars.yml # Версия ClickHouse
│ │ └── vector/vars.yml # Версия Vector, пути
│ ├── templates/
│ │ ├── vector.yml.j2 # Конфиг Vector
│ │ ├── vector.service.j2 # Systemd unit Vector
│ │ └── lighthouse.nginx.conf.j2 # Конфиг Nginx
│ └── site.yml # Основной playbook
├── .gitignore
└── README.md


## Требования

- Terraform 1.0+ (для создания инфраструктуры)
- Ansible 2.15+
- SSH-ключ для доступа к ВМ
- Yandex Cloud аккаунт

## Переменные

### ClickHouse (`group_vars/clickhouse/vars.yml`)

| Переменная | Значение по умолчанию | Описание |
|------------|------------------------|----------|
| `clickhouse_version` | `26.3.9.8` | Версия ClickHouse (LTS) |

### Vector (`group_vars/vector/vars.yml`)

| Переменная | Значение по умолчанию | Описание |
|------------|------------------------|----------|
| `vector_version` | `0.39.0` | Версия Vector |
| `vector_install_dir` | `/opt/vector` | Директория установки |
| `vector_config_dir` | `/etc/vector` | Директория конфигурации |
| `vector_data_dir` | `/var/lib/vector` | Директория данных |
| `clickhouse_host` | `10.128.0.X` | Внутренний IP ClickHouse |

### LightHouse (`group_vars/lighthouse/vars.yml`)

| Переменная | Значение | Описание |
|------------|----------|----------|
| `clickhouse_host` | `10.128.0.X` | Внутренний IP ClickHouse |

## Теги

| Тег | Описание |
|-----|----------|
| `clickhouse` | Только ClickHouse |
| `vector` | Только Vector |
| `lighthouse` | Только Lighthouse |
| `database` | Работа с БД и таблицами |
| `packages` | Установка пакетов |
| `config` | Конфигурационные файлы |
| `install` | Установка и копирование |
| `service` | Управление сервисами |
| `download` | Скачивание дистрибутивов |
| `deps` | Установка зависимостей |

## Быстрый старт

### 1. Создание инфраструктуры

```bash
cd terraform
cp terraform.tfvars.example terraform.tfvars
# Заполните terraform.tfvars данными Yandex Cloud
terraform init
terraform apply -auto-approve
```

### 2. Настройка инвентаря

```bash
cd ../playbook
# Обновите inventory/prod.yml IP адресами из вывода terraform output
```

### 3. Проверка и запуск

```bash
# Проверка подключения
ansible -i inventory/prod.yml all -m ping

# Проверка синтаксиса
ansible-lint site.yml

# Запуск playbook
ansible-playbook -i inventory/prod.yml site.yml --diff

# Проверка идемпотентности (должно быть changed=0)
ansible-playbook -i inventory/prod.yml site.yml --diff
```

### 4. Использование тегов

```bash
# Только ClickHouse
ansible-playbook -i inventory/prod.yml site.yml --tags clickhouse

# Только Vector
ansible-playbook -i inventory/prod.yml site.yml --tags vector

# Только Lighthouse
ansible-playbook -i inventory/prod.yml site.yml --tags lighthouse

# Только конфигурация
ansible-playbook -i inventory/prod.yml site.yml --tags config

# Пропустить установку пакетов
ansible-playbook -i inventory/prod.yml site.yml --skip-tags packages
```
---

### 5. Проверка работы

```bash
# Проверка синтаксиса
ansible-lint site.yml

# Статус сервисов
ansible all -i inventory/prod.yml -m shell -a "systemctl is-active clickhouse-server vector nginx" --become

# Данные в ClickHouse
ansible clickhouse -i inventory/prod.yml -m shell -a "clickhouse-client -q 'SELECT count() FROM logs.vector_logs;'"

# Lighthouse (должен вернуть 200)
curl -s -o /dev/null -w "%{http_code}" http://<LIGHTHOUSE_IP>
```
### Результаты проверок

![Результаты](https://github.com/IthnHuitn/ansible-01-base/blob/ansible-03/screens/ansible1-5.png)

#### `Идемпотентность`
![Идемпотентность](https://github.com/IthnHuitn/ansible-01-base/blob/ansible-03/screens/ansible1-1.png)
![Идемпотентность](https://github.com/IthnHuitn/ansible-01-base/blob/ansible-03/screens/ansible1-2.png)

#### `LightHouse`
![LightHouse](https://github.com/IthnHuitn/ansible-01-base/blob/ansible-03/screens/ansible1-4.png)

---
