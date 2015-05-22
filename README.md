# fe-env-conf
### Автоматичеcкая настройка среды frontend-разработчика НГС

Данный инструмент создан, чтобы не настраивать созданную или пересозданную среду вручную.

*Алгоритм действий:*
 1. Склонируйте репозиторий с github'а или просто скачайте папку со скриптом, например в home/user:

    git clone https://github.com/opiumind/fe-env-conf.git

 2. Занесите необходимые данные в конфиг fe-env-conf-config.sh, чтобы не вводить все вручную

 3. Запустите скрипт fe-env-conf-start.sh у себя на локальной машине из той директории, где он лежит, передав при этом аргументом название среды, например:

    cd /home/user/fe-env-conf

    fe-env-conf-start.sh lol.d

 4. Далее следуйте инструкциям, которые будут в логе выполнения скрипта

 5. При монтировании директории с проектом к себе локально через sshfs укажите параметр follow_symlinks:

    sshfs -o follow_symlinks,nonempty o.lisovskaya@ngs.ru.lol.d:/data/projects /home/lisovskaya/projects/


*Что делает данный скрипт:*
 * Создает на среде пользователя, пользовательскую директорию, добавляет пользователя в группу sudo

 * Выкладывает проект последней версии

 * Ставит git, прописывает для него user.name и user.email

 * Инициализирует репозиторий проекта