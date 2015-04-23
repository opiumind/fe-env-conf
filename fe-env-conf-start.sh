#!/bin/sh

#1 Скрипт, который нужно запустить, чтобы началась автоматичсекая настройка среды
# $1=o.d

if [ -z "$1" ]; then
    echo "Вы забыли указать при запуске скрипта название вашей среды (например, ig.d)"
    exit 1
fi

if [ ! -a fe-env-conf-config.sh ]; then
    read -p "Укажите ваш username (например, o.lisovskaya):" username
    read -p "Укажите ваш проект (например, realty.ngs.ru):" project
    read -p "jiraid (например, rn):" jiraid
    read -p "Укажите репу вашего проекта (например, ssh://git@git.rn/ngs/rn.git). Можно посмотреть на git.rn:" projectrep
    read -p "Какой name в git'е хотите? (например, Olga Lisovskaya):" gitname

    echo "Советую указать эти данные в fe-env-conf-config.sh, чтобы в следующий раз не пришлось вводить вручную."
else
    source fe-env-conf-config.sh
fi

ssh root@ngs.ru.$1 "username=$username project=$project bash -s" < fe-env-conf-user.sh && \
ssh $username@ngs.ru.$1 "env=$1 username=$username project=$project jiraid=$jiraid projectrep=$projectrep $gitname=gitname bash -s" < fe-env-conf-other.sh && \
