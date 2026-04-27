# Домашнее задание к занятию "`Введение в Ansible`" - `Ефимов Вячеслав`


### Инструкция по выполнению домашнего задания

   1. Сделайте `fork` данного репозитория к себе в Github и переименуйте его по названию или номеру занятия, например, https://github.com/имя-вашего-репозитория/git-hw или  https://github.com/имя-вашего-репозитория/7-1-ansible-hw).
   2. Выполните клонирование данного репозитория к себе на ПК с помощью команды `git clone`.
   3. Выполните домашнее задание и заполните у себя локально этот файл README.md:
      - впишите вверху название занятия и вашу фамилию и имя
      - в каждом задании добавьте решение в требуемом виде (текст/код/скриншоты/ссылка)
      - для корректного добавления скриншотов воспользуйтесь [инструкцией "Как вставить скриншот в шаблон с решением](https://github.com/netology-code/sys-pattern-homework/blob/main/screen-instruction.md)
      - при оформлении используйте возможности языка разметки md (коротко об этом можно посмотреть в [инструкции  по MarkDown](https://github.com/netology-code/sys-pattern-homework/blob/main/md-instruction.md))
   4. После завершения работы над домашним заданием сделайте коммит (`git commit -m "comment"`) и отправьте его на Github (`git push origin`);
   5. Для проверки домашнего задания преподавателем в личном кабинете прикрепите и отправьте ссылку на решение в виде md-файла в вашем Github.
   6. Любые вопросы по выполнению заданий спрашивайте в чате учебной группы и/или в разделе “Вопросы по заданию” в личном кабинете.
   
Желаем успехов в выполнении домашнего задания!
   
### Дополнительные материалы, которые могут быть полезны для выполнения задания

1. [Руководство по оформлению Markdown файлов](https://gist.github.com/Jekins/2bf2d0638163f1294637#Code)

---

### Задание


### 1. `Значение some_fact для localhost = 12`

![ansible1-1](https://github.com/IthnHuitn/ansible-01-base/blob/master/screens/ansible1-1.png)

### 2. `Изменение переменной в group_vars/all`

![ansible1-2](https://github.com/IthnHuitn/ansible-01-base/blob/master/screens/ansible1-2.png)

### 3-4. `Запуск на prod.yml с Docker`
- centos7: `el`
- ubuntu: `deb`

### 5-6. `Добавление специфичных фактов для групп`
- deb: `deb default fact`
- el: `el default fact`

### 7-8. `Шифрование с помощью ansible-vault`
Файлы `group_vars/deb/examp.yml` и `group_vars/el/examp.yml` зашифрованы паролем `netology`

![ansible1-3](https://github.com/IthnHuitn/ansible-01-base/blob/master/screens/ansible1-3.png)

### 9. `Плагины подключения`
Для control node подходит плагин `local`

### 10-11. `Добавление группы local`
Добавлена группа `local` с localhost и подключением `local`
Финальные значения some_fact:
- centos7: `el default fact`
- ubuntu: `deb default fact`  
- localhost: `all default fact`

![ansible1-4](https://github.com/IthnHuitn/ansible-01-base/blob/master/screens/ansible1-4.png)

---


## Необязательная часть

### 1-3 `Передача зашифрованного значения PaSSw0rd для нужных хостов`

![ansible1-5](https://github.com/IthnHuitn/ansible-01-base/blob/master/screens/ansible1-5.png)
![ansible1-6](https://github.com/IthnHuitn/ansible-01-base/blob/master/screens/ansible1-6.png)


