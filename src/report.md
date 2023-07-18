# Simple Docker

## Part 1. Готовый докер

В начале вам нужно разобраться с уже готовым докер образом **nginx** для сервера.

- Взять официальный докер образ с **nginx** и выкачать его при помощи `docker pull`

- Проверить наличие докер образа через `docker images`

![dockerpull_images](./img/1part/dockerpull_images.png)

- Запустить докер образ через `docker run -d [image_id|repository]`

- Проверить, что образ запустился через `docker ps`

![dockerrun_ps](./img/1part/dockerrun_ps.png)

- Посмотреть информацию о контейнере через `docker inspect [container_id|container_name]`

![dockerinspect](./img/1part/dockerinspect.png)

- По выводу команды определить и поместить в отчёт размер контейнера, список замапленных портов и ip контейнера

- Размер контейнера: 1.09kB (`"SizeRw": 1095,`)
- Замапленные порты: `"Ports": {"80/tcp": null},`
- IP контейнера: `"IPAddress": "172.17.0.2",`

- Остановить докер образ через `docker stop [container_id|container_name]`

- Проверить, что образ остановился через `docker ps`

![dockerstop_ps](./img/1part/dockerstop_ps.png)

- Запустить докер с портами 80 и 443 в контейнере, замапленными на такие же порты на локальной машине, через команду *run*

`docker run -d -p 80:80 -p 443:443 nginx`
![dockerrun_port80_443](./img/1part/dockerrun_port80_443.png)

- Проверить, что в браузере по адресу *localhost:80* доступна стартовая страница **nginx**

![localhost80](./img/1part/localhost80.png)

- Перезапустить докер контейнер через `docker restart [container_id|container_name]`

- Проверить любым способом, что контейнер запустился

![dockerrestart_ps](./img/1part/dockerrestart_ps.png)

## Part 2. Операции с контейнером

Докер образ и контейнер готовы. Теперь можно покопаться в конфигурации **nginx** и отобразить статус страницы.

- Прочитать конфигурационный файл *nginx.conf* внутри докер контейнера через команду *exec*

`docker exec gallant_newton cat /etc/nginx/nginx.conf`
![dockerexec](./img/2part/dockerexec.png)

- Создать на локальной машине файл *nginx.conf*

`mkdir -p nginx && cd nginx`

`nano nginx.conf`

- Настроить в нем по пути */status* отдачу страницы статуса сервера **nginx**

![dockerexec](./img/2part/nginxconf.png)

- Скопировать созданный файл *nginx.conf* внутрь докер образа через команду `docker cp`

- Перезапустить **nginx** внутри докер образа через команду *exec*

![cp_exec](./img/2part/cp_exec.png)

- Проверить, что по адресу *localhost:80/status* отдается страничка со статусом сервера **nginx**

![status80](./img/2part/status80.png)

- Экспортировать контейнер в файл *container.tar* через команду *export*

- Остановить контейнер

- Удалить образ через `docker rmi [image_id|repository]`, не удаляя перед этим контейнеры

- Удалить остановленный контейнер

![export_rmi](./img/2part/export_rmi.png)

- Импортировать контейнер обратно через команду *import*

- Запустить импортированный контейнер

![import_ps](./img/2part/import_ps.png)

- Проверить, что по адресу *localhost:80/status* отдается страничка со статусом сервера **nginx**

![status80](./img/2part/status80_2.png)
