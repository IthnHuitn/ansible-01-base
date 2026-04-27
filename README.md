# Домашнее задание к занятию "`Работа с Playbook`" - `Ефимов Вячеслав`


# Ansible Playbook для установки ClickHouse и Vector

Автоматическое развертывание ClickHouse и Vector на AlmaLinux 10 в Яндекс Облаке.

## Описание

Данный playbook автоматизирует установку и настройку:
- **ClickHouse** — колоночная аналитическая СУБД
- **Vector** — сборщик и трансформатор логов

Playbook выполняет:
1. Установку ClickHouse из официальных RPM-пакетов (LTS версия)
2. Настройку ClickHouse для приема подключений со всех интерфейсов
3. Создание базы данных `logs` и таблицы `vector_logs` в ClickHouse
4. Установку Vector из официального дистрибутива
5. Настройку Vector для генерации демо-логов и отправки их в ClickHouse

## Требования

### Инфраструктура
- Два хоста на AlmaLinux 10 (или совместимом RPM-based дистрибутиве)
- Минимум 2 ГБ RAM, 2 vCPU
- Доступ по SSH с ключом
- Сетевой доступ между хостами (порт 8123 для ClickHouse)

### Локальное окружение
- Ansible 2.9+
- Terraform 1.0+ (опционально, для создания инфраструктуры)
- SSH-ключ для доступа к хостам

## Переменные

### ClickHouse (`group_vars/clickhouse/vars.yml`)

| Переменная | Описание | Значение по умолчанию |
|------------|----------|------------------------|
| `clickhouse_version` | Версия ClickHouse для установки | `26.3.9.8` |

### Vector (`group_vars/vector/vars.yml`)

| Переменная | Описание | Значение по умолчанию |
|------------|----------|------------------------|
| `vector_version` | Версия Vector для установки | `0.39.0` |
| `vector_install_dir` | Директория установки Vector | `/opt/vector` |
| `vector_config_dir` | Директория конфигурации Vector | `/etc/vector` |
| `vector_data_dir` | Директория данных Vector | `/var/lib/vector` |
| `clickhouse_host` | Внутренний IP или хостнейм ClickHouse | `ваш внутренний IP` |

## Инвентарь

Пример `inventory/prod.yml`:

```yaml
---
clickhouse:
  hosts:
    clickhouse-01:
      ansible_host: <IP_clickhouse>
      ansible_user: cloud-user
      ansible_ssh_private_key_file: /home/user/.ssh/id_rsa
      ansible_ssh_common_args: '-o StrictHostKeyChecking=no'
      become: true
      become_user: root

vector:
  hosts:
    vector-01:
      ansible_host: <IP_vector>
      ansible_user: cloud-user
      ansible_ssh_private_key_file: /home/user/.ssh/id_rsa
      ansible_ssh_common_args: '-o StrictHostKeyChecking=no'
      become: true
      become_user: root
```

## Теги

Playbook поддерживает теги для выборочного запуска отдельных частей:

| Тег | Описание |
|-----|----------|
| `clickhouse` | Все задачи, связанные с ClickHouse |
| `vector` | Все задачи, связанные с Vector |
| `packages` | Установка пакетов и зависимостей |
| `download` | Скачивание дистрибутивов |
| `install` | Установка из скачанных пакетов |
| `config` | Применение конфигурации |
| `clickhouse-config` | Только конфигурация ClickHouse |
| `vector-config` | Только конфигурация Vector |
| `database` | Создание базы данных и таблиц |
| `table` | Только создание таблиц |
| `directories` | Создание директорий для Vector |
| `service` | Управление systemd сервисами |
| `deps` | Установка зависимостей |

### Примеры использования тегов:

```bash
# Запустить только установку ClickHouse
ansible-playbook -i inventory/prod.yml site.yml --tags clickhouse

# Запустить только установку Vector
ansible-playbook -i inventory/prod.yml site.yml --tags vector

# Только настройка конфигурации
ansible-playbook -i inventory/prod.yml site.yml --tags config

# Только создание базы данных и таблиц
ansible-playbook -i inventory/prod.yml site.yml --tags database

# Установка пакетов без настройки
ansible-playbook -i inventory/prod.yml site.yml --tags install

# Пропустить загрузку (если пакеты уже скачаны)
ansible-playbook -i inventory/prod.yml site.yml --skip-tags download

# Только настройка ClickHouse
ansible-playbook -i inventory/prod.yml site.yml --tags clickhouse-config

# Всё, кроме создания таблиц
ansible-playbook -i inventory/prod.yml site.yml --skip-tags table
```


---

### Задания

```bash
ansible-lint site.yml
```

![Ansible1-1](https://github.com/IthnHuitn/ansible-01-base/blob/ansible-02/screens/ansible1-1.png)

```bash
ansible-playbook -i inventory/prod.yml site.yml --check
```


![Ansible1-2](https://github.com/IthnHuitn/ansible-01-base/blob/ansible-02/screens/ansible1-2.png)


```bash
ansible-playbook -i inventory/prod.yml site.yml --diff
```
![Ansible1-3](https://github.com/IthnHuitn/ansible-01-base/blob/ansible-02/screens/ansible1-3.png)


---

