# fe-env-conf
Автоматичеcкая настройка среды fe разработчика НГС

Данный инструмент создан, чтобы не настраивать созданную или пересозданную среду вручную.

Алгоритм действий:
 1. git clone https://github.com/opiumind/fe-env-conf.git (или просто скачайте папку со скриптами)
    cd fe-env-conf

 2. Занесите необходимые данные в конфиг fe-env-conf-config.sh (необязательно)

 3. Запустите скрипт fe-env-conf-start.sh у себя на локальной машине, передав при этом аргументом название среды, например:
    ./fe-env-conf-start.sh lol.d

 4. Если все необходимые данные в конфиге, расслабьтесь и отдохните
